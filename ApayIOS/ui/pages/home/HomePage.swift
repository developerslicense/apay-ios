//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI
import SwiftUI_SimpleToast

struct HomePage: View {
    @StateObject var viewModel = HomePageViewModel()

    @State var showDialogExit: Bool = false
    @State var switchSaveCard: Bool = false

    @State private var sheetState = false
    @State var showToast: Bool = false
    private let toastOptions = SimpleToastOptions(hideAfter: 5)

    private var selectedCardId: String? = nil//"64e47088b45d2f8513a29185"

    var body: some View {
        ZStack {
            ColorsSdk.bgBlock

            GeometryReader { metrics in
                VStack {
                    ViewToolbar(
                            title: paymentOfPurchase(),
                            actionShowDialogExit: { showDialogExit = true }
                    )
                            .frame(maxWidth: .infinity, alignment: .leading)

                    TopInfoView(purchaseAmount: DataHolder.purchaseAmountFormatted)
                            .padding(.top, 24)
                            .padding(.horizontal, 16)

                    CardNumberView(viewModel: viewModel)
                            .padding(.top, 16)
                            .padding(.horizontal, 16)

                    HStack(alignment: .top) {
                        DateExpiredView(viewModel: viewModel)

                        Spacer().frame(width: 12)

                        CvvView(
                                viewModel: viewModel,
                                actionClickInfo: {
                                    sheetState.toggle()
                                }
                        )
                    }
                            .padding(.horizontal, 16)
                            .frame(width: .infinity)

                    SwitchedView(
                            text: saveCardData(),
                            switchCheckedState: switchSaveCard,
                            actionOnTrue: {
                                withAnimation {
                                    showToast.toggle()
                                }
                            }
                    )
                            .padding(.top, 24)


                    BottomImages()
                            .padding(.top, 35)
                            .padding(.horizontal, 16)
                }
            }

            if viewModel.isLoading {
                ColorsSdk.gray15
                        .opacity(0.8)
                        .onTapGesture(perform: {})
                ProgressBarView()
            }
        }
                .modifier(
                        Popup(
                                isPresented: showDialogExit,
                                content: {
                                    DialogExit(onDismissRequest: { showDialogExit = false })
                                })
                )
                .onTapGesture(perform: { showDialogExit = false })
                .sheet(isPresented: $sheetState) {
                    CvvBottomSheet()
                }
                .overlay(ViewButton(
                        title: payAmount() + " " + DataHolder.purchaseAmountFormatted,
                        actionClick: {
                            if !viewModel.isLoading {
                                onClick()
                            }
                        }
                )
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 24)
                        .padding(.horizontal, 16), alignment: .bottom)
                .simpleToast(isPresented: $showToast, options: toastOptions) {
                    Label(cardDataSaved(), systemImage: "icAdd")
                            .padding()
                            .background(Color.gray.opacity(0.9))
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .padding(.top)
                }
                .onAppear {
                    if (selectedCardId != nil) {
                        viewModel.isLoading = true

                        startPaymentProcessing(
                                isLoading: { isLoading in
                                    viewModel.isLoading = isLoading
                                },
                                cardId: selectedCardId!
                        )

                    } else {
                        viewModel.isLoading = false
                    }
                }

    }

    private func onClick() {
        UIApplication.shared.endEditing()

        print("aaaaa_ " + viewModel.cardNumberText +
                " | " + viewModel.dateExpiredText +
                " | " + viewModel.cvvText)

        let validationResult = checkValid(
                cardNumber: viewModel.cardNumberText,
                dateExpired: viewModel.dateExpiredText,
                cvv: viewModel.cvvText
        )

        print("aaaaa ")
        print(validationResult)

        if (validationResult.errorCardNumber == nil
                && validationResult.errorCvv == nil
                && validationResult.errorDateExpired == nil
           ) {
            viewModel.changeErrorState()
            viewModel.isLoading = true

            var card = viewModel.cardNumberText
            card.replace(" ", with: "")

            Task {
                await getCardsBankService(
                        pan: card,
                        next: {
                            startPaymentProcessing(
                                    isLoading: { isLoading in
                                        viewModel.isLoading = isLoading
                                    },
                                    saveCard: switchSaveCard,
                                    cardNumber: viewModel.cardNumberText,
                                    dateExpired: viewModel.dateExpiredText,
                                    cvv: viewModel.cvvText
                            )
                        },
                        isLoading: { isLoading in
                            viewModel.isLoading = isLoading
                        }
                )
            }

        } else {
            viewModel.changeErrorState(
                    cardNumberError: validationResult.errorCardNumber,
                    dateExpiredError: validationResult.errorDateExpired,
                    cvvError: validationResult.errorCvv
            )
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

