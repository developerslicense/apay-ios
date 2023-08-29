//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI
import SwiftUI_SimpleToast

struct HomePage: View {
    @State var showDialogExit: Bool = false
    @State var switchSaveCard: Bool = false

    @State var cardNumberText: String = ""
    @State var dateExpiredText: String = ""
    @State var cvvText: String = ""

    @State var cardNumberError: String? = nil
    @State var dateExpiredError: String? = nil
    @State var cvvError: String? = nil

    @State private var sheetState = false
    @State var showToast: Bool = false
    private let toastOptions = SimpleToastOptions(hideAfter: 5)

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

    }
}


/*


                }

                ViewButton(
                    title = "${payAmount()} ${purchaseAmount.value}",
                    actionClick = {
                        focusManager.clearFocus(true)

                        val isValid = checkValid(
                            emailError = emailError,
                            cardNumber = cardNumberText.value.text,
                            cardNumberError = cardNumberError,
                            dateExpired = dateExpiredText.value.text,
                            dateExpiredError = dateExpiredError,
                            cvvError = cvvError,
                            cvv = cvvText.value.text
                        )

                        if (isValid) {
                            isLoading.value = true

                            cardRepository.getCardsBank(
                                pan = cardNumberText.value.text.replace(" ", ""),
                                coroutineScope = coroutineScope,
                                next = {
                                    startPaymentProcessing(
                                        navController = navController,
                                        isLoading = isLoading,
                                        saveCard = switchSaveCard.value,
                                        cardNumber = cardNumberText.value.text,
                                        cvv = cvvText.value.text,
                                        dateExpired = dateExpiredText.value.text,
                                        coroutineScope = coroutineScope,
                                        authRepository = authRepository,
                                        paymentsRepository = paymentsRepository
                                    )
                                }
                            )
                        }
                    },
                    modifierRoot = Modifier
                        .padding(horizontal = 16.dp)
                        .padding(bottom = 16.dp)
                )


            }


            if (isLoading.value) {
                ProgressBarView()
            }
        }
    }

    LaunchedEffect("Has CardId") {

        if (selectedCardId != null) {
            startPaymentProcessing(
                navController = navController,
                isLoading = isLoading,
                coroutineScope = coroutineScope,
                paymentsRepository = paymentsRepository,
                cardId = selectedCardId
            )

        } else {
            isLoading.value = false
        }
    }*/
