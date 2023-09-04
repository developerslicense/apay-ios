//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI
import SwiftUI_SimpleToast

struct StartProcessingView: View {
    @StateObject var viewModel = StartProcessingViewModel()

//    @Environment(\.dismiss) var dismiss

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
//                                            dismiss()
                                        }
                                )

                                if (viewModel.isError) {
                                    InitErrorState()

                                } else {
                                    InitViewStartProcessingAmount()
                                    //                        InitViewStartProcessingAPay()  //todo временно закоментировал

                                    if (!viewModel.savedCards.isEmpty
                                            && isAuthenticated
                                       ) {
                                        InitViewStartProcessingCards(// todo внутри есть закоментированное
                                                savedCards: viewModel.savedCards,
                                                selectedCard: viewModel.selectedCard
//                                    actionClose: actionClose
                                        )
                                    }

                                    InitViewStartProcessingButtonNext(
                                            savedCards: viewModel.savedCards,
                                            actionClose: actionClose,
                                            isAuthenticated: isAuthenticated,
                                            selectedCard: viewModel.selectedCard
                                    )
                                }
                                Spacer()
                            }

                            if (isLoading) {
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
                                showToast = true
                                isLoading = false
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

