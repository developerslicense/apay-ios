//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI
import SwiftUI_SimpleToast

struct HomePage: View {
    @State var showDialogExit: Bool = false
    @State var switchSaveCard: Bool = false
    @State var isLoading: Bool = true

    @State var cardNumberText: String = ""
    @State var dateExpiredText: String = ""
    @State var cvvText: String = ""

    @State var cardNumberError: String? = nil
    @State var dateExpiredError: String? = nil
    @State var cvvError: String? = nil

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

                    CardNumberView(
                            cardNumberText: cardNumberText,
                            cardNumberError: cardNumberError
                    )
                            .padding(.top, 16)
                            .padding(.horizontal, 16)

                    HStack {
                        DateExpiredView(
                                dateExpiredText: dateExpiredText,
                                dateExpiredError: dateExpiredError
                        )

                        Spacer().frame(width: 12)

                        CvvView(
                                cvvText: cvvText,
                                cvvError: cvvError,
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

            if isLoading {
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
                            UIApplication.shared.endEditing()

                            let validationResult = checkValid(
                                    cardNumber: cardNumberText,
                                    dateExpired: dateExpiredText,
                                    cvv: cvvText
                            )

                            print("aaaaa ")
                            print(validationResult)

                            if (validationResult.errorCardNumber == nil
                                    && validationResult.errorCvv == nil
                                    && validationResult.errorDateExpired == nil
                               ) {
                                isLoading = true
                                var card = cardNumberText
                                card.replace(" ", with: "")

                                Task {
                                    await getCardsBankService(
                                            pan: card,
                                            next: {
                                                startPaymentProcessing(
                                                        isLoading: { isLoading in
                                                            self.isLoading = isLoading
                                                        },
                                                        saveCard: switchSaveCard,
                                                        cardNumber: cardNumberText,
                                                        dateExpired: dateExpiredText,
                                                        cvv: cvvText
                                                )
                                            }
                                    )
                                }
                            } else {
// todo
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
                        startPaymentProcessing(
                                isLoading: { isLoading in
                                    self.isLoading = isLoading
                                },
                                cardId: selectedCardId!
                        )

                    } else {
                        isLoading = false
                    }
                }

    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

