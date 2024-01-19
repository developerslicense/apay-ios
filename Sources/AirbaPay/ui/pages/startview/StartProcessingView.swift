//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI
import SimpleToast

struct StartProcessingView: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    @StateObject var viewModel = StartProcessingViewModel()

    @State var presentSheet: Bool = false
    @State var needShowProgressBar: Bool = true
    var backgroundColor: Color = ColorsSdk.bgBlock

    @State private var isAuthenticated: Bool = false
    @State private var showToast: Bool = false
    @State private var isLoading: Bool = true
    @State private var needApplePay: Bool = false
    @State private var sheetState = false

    private let toastOptions = SimpleToastOptions(hideAfter: 5)

    var body: some View {
        ColorsSdk.bgBlock.overlay(
                        ZStack {
                            VStack {

                                ViewToolbar(
                                        title: paymentByCard(),
                                        actionClickBack: {
                                            navigateCoordinator.backToApp()
                                        }
                                )
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                if (viewModel.isError) {
                                    InitErrorState()

                                } else {
                                    InitViewStartProcessingAmount()

                                    if DataHolder.needApplePay && viewModel.applePayUrl != nil {
                                        ApplePayPage(
                                                redirectUrl: viewModel.applePayUrl,
                                                navigateCoordinator: navigateCoordinator
                                        )
                                                .frame(width: .infinity, height: 48)
                                                .padding(.top, 8)
                                                .padding(.horizontal, 16)
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
                                            showCvv: { sheetState.toggle() },
                                            isLoading: { b in
                                                isLoading = b
                                            },
                                            selectedCard: viewModel.selectedCard,
                                            isAuthenticated: isAuthenticated,
                                            needTopPadding: !viewModel.savedCards.isEmpty
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
                                    await viewModel.authAndLoadData()
                                    isAuthenticated = true
                                    isLoading = false

                                }
                            },
                            onError: {
                                Task {
                                    await viewModel.authAndLoadData()
                                    isLoading = false
                                }
                            }
                    )

                }
                .sheet(isPresented: $sheetState) {

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

