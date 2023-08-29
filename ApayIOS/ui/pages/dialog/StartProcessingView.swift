//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI
import SwiftUI_SimpleToast

struct StartProcessingView: View {
    @StateObject var viewModel = StartProcessingViewModel()

    @Environment(\.dismiss) var dismiss

    @State var presentSheet: Bool = false
    @State var isError: Bool = false
    @State var needShowProgressBar: Bool = true
    var actionClose: () -> Void
    var backgroundColor: Color = ColorsSdk.bgBlock
    @State var selectedCard: BankCard? = nil

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
                                            dismiss()
                                        }
                                )

                                if (isError) {
                                    InitErrorState()

                                } else {
                                    InitViewStartProcessingAmount()
                                    //                        InitViewStartProcessingAPay()  //todo временно закоментировал

                                    if (!viewModel.savedCards.isEmpty
                                            && isAuthenticated
                                       ) {
                                        InitViewStartProcessingCards(// todo внутри есть закоментированное
                                                savedCards: viewModel.savedCards,
                                                selectedCard: selectedCard
//                                    actionClose: actionClose
                                        )
                                    }

                                    InitViewStartProcessingButtonNext(
                                            savedCards: viewModel.savedCards,
                                            actionClose: actionClose,
                                            isAuthenticated: isAuthenticated,
                                            selectedCard: selectedCard
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
                                    await viewModel.fetchAppliances()
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

