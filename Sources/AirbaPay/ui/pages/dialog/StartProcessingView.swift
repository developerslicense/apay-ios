//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI
//import SwiftUI_SimpleToast
import SimpleToast

struct StartProcessingView: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    @StateObject var viewModel = StartProcessingViewModel()

    @State var presentSheet: Bool = false
    @State var needShowProgressBar: Bool = true
    var actionClose: () -> Void
    var backgroundColor: Color = ColorsSdk.bgBlock

    @State private var isAuthenticated: Bool = false
    @State private var showToast: Bool = false
    @State private var isLoading: Bool = true
    private let toastOptions = SimpleToastOptions(hideAfter: 5)

    var body: some View {
        ColorsSdk.bgBlock.overlay(
                        ZStack {
                            VStack {
                                InitHeader(
                                        title: paymentByCard(),
                                        actionClose: {
                                            navigateCoordinator.backToApp()
                                        }
                                )

                                if (viewModel.isError) {
                                    InitErrorState()

                                } else {
                                    InitViewStartProcessingAmount()

                                    if DataHolder.needApplePay {
                                        InitViewStartProcessingAPay(
                                                isLoading: { isLoading in
                                                    self.isLoading = isLoading
                                                },
                                                navigateCoordinator: navigateCoordinator
                                        )
                                    }

                                    if (!viewModel.savedCards.isEmpty
                                            && isAuthenticated
                                       ) {
                                        InitViewStartProcessingCards(
                                                navigateCoordinator: navigateCoordinator,
                                                savedCards: viewModel.savedCards,
                                                selectedCard: viewModel.selectedCard
                                        )
                                    }

                                    InitViewStartProcessingButtonNext(
                                            navigateCoordinator: navigateCoordinator,
                                            savedCards: viewModel.savedCards,
                                            actionClose: actionClose,
                                            isAuthenticated: isAuthenticated,
                                            selectedCard: viewModel.selectedCard
                                    )
                                }
                                Spacer()
                            }

                            if (isLoading) {
                                ColorsSdk.bgMain
                                ProgressBarView()
                            }
                        }
                )
                .onAppear {
                    airbaPayBiometricAuthenticate(
                            onSuccess: {
                                Task {
                                    await viewModel.authAndLoadCards()
                                    isAuthenticated = true
                                    isLoading = false
                                }
                            },
                            onError: {
                                Task {
                                    await viewModel.authAndLoadCards()
                                    isLoading = false
                                }
                            }
                    )
                }
                .simpleToast(isPresented: $showToast, options: toastOptions) {
                    Label(accessToCardRestricted(), systemImage: "icAdd")
                            .padding()
                            .background(Color.gray.opacity(0.9))
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .padding(.top)
                }
    }
}

