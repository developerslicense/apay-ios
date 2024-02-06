//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI
import SimpleToast

struct HomePage: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    @StateObject var viewModel = HomePageViewModel()
    @StateObject var cardNumberEditTextViewModel = CoreEditTextViewModel()
    @StateObject var dateExpiredEditTextViewModel = CoreEditTextViewModel()
    @StateObject var cvvEditTextViewModel = CoreEditTextViewModel()

    @State var showDialogExit: Bool = false
    @State var switchSaveCard: Bool = false
    @State var showCardScanner: Bool = false

    @State private var sheetState = false
    @State var saveCardToast: Bool = false
    @State var errorCardParserToast: Bool = false
    private let toastOptions = SimpleToastOptions(hideAfter: 5)

    var maskedPan: String? = nil
    var dateExpired: String? = nil

    init(
            @ObservedObject navigateCoordinator: AirbaPayCoordinator,
            maskedPan: String? = nil,
            dateExpired: String? = nil
    ) {
        self.navigateCoordinator = navigateCoordinator
        self.maskedPan = maskedPan
        self.dateExpired = dateExpired
    }

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgBlock

            GeometryReader { metrics in
                VStack {
                    ViewToolbar(
                            title: paymentOfPurchase(),
                            actionClickBack: {
                                if (
                                           viewModel.dateExpiredText.isEmpty
                                                   && viewModel.cardNumberText.isEmpty
                                                   && viewModel.cvvText.isEmpty
                                   ) {
                                    if !DataHolder.featureSavedCards || !DataHolder.hasSavedCards {
                                        navigateCoordinator.backToApp()
                                    } else {
                                        navigateCoordinator.backToStartPage()
                                    }
                                }
                                else {
                                    showDialogExit = true
                                }
                            }
                    )
                            .frame(maxWidth: .infinity, alignment: .leading)

                    TopInfoView(purchaseAmount: DataHolder.purchaseAmountFormatted)
                            .padding(.top, 24)
                            .padding(.horizontal, 16)

                    if DataHolder.featureApplePay {
                        ApplePayPage(
                                redirectUrl: DataHolder.applePayButtonUrl,
                                navigateCoordinator: navigateCoordinator
                        )
                                .frame(width: .infinity, height: 48)
                                .padding(.top, 16)
                                .padding(.horizontal, 16)
                    }

                    CardNumberView(
                            viewModel: viewModel,
                            editTextViewModel: cardNumberEditTextViewModel,
                            actionClickScanner: {
                                UIApplication.shared.endEditing()
                                showCardScanner = true
                            }
                    )
                            .padding(.top, 16)
                            .padding(.horizontal, 16)

                    HStack(alignment: .top) {
                        DateExpiredView(
                                viewModel: viewModel,
                                editTextViewModel: dateExpiredEditTextViewModel
                        )

                        Spacer().frame(width: 12)

                        CvvView(
                                viewModel: viewModel,
                                editTextViewModel: cvvEditTextViewModel,
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
                            actionOnChanged: { isSwitched in
                                if isSwitched {
                                    withAnimation { saveCardToast.toggle() }
                                }

                                viewModel.switchSaveCard = isSwitched
                            }
                    )
                            .padding(.top, 24)


                    BottomImages()
                            .padding(.top, 35)
                            .padding(.horizontal, 16)
                }
            }

            if showCardScanner {

                CardScannerPage(
                        onSuccess: { cardNumber in
                            showCardScanner = false
                            cardNumberEditTextViewModel.changeText(text: cardNumber)
                        },
                        onBackEmpty: {
                            showCardScanner = false
                            withAnimation { errorCardParserToast.toggle() }
                        }
                )
            }

            if viewModel.isLoading {
                ColorsSdk.gray15
                        .opacity(0.99)
                        .onTapGesture(perform: {})
                ProgressBarView()
            }
        }
                .modifier(
                        Popup(
                                isPresented: showDialogExit,
                                content: {
                                    DialogExit(
                                            onDismissRequest: { showDialogExit = false },
                                            backToApp: { navigateCoordinator.backToApp() }
                                    )
                                })
                )
                .onTapGesture(perform: {
                    showDialogExit = false
                    UIApplication.shared.endEditing()
                })
                .sheet(isPresented: $sheetState) {
                    CvvBottomSheet(actionClose: { sheetState.toggle() } )
                }
                .overlay(
                        ViewButton(
                                title: payAmount() + " " + DataHolder.purchaseAmountFormatted,
                                actionClick: {
                                    if !viewModel.isLoading {
                                        onClick()
                                    }
                                },
                                isVisible: !showCardScanner && !viewModel.isLoading && !showDialogExit
                        )
                                .frame(maxWidth: .infinity)
                                .padding(.bottom, 24)
                                .padding(.horizontal, 16),
                        alignment: .bottom
                )
                .simpleToast(isPresented: $errorCardParserToast, options: toastOptions) {
                    Label(cardParserCancel(), systemImage: "icAdd")
                            .padding()
                            .background(Color.gray.opacity(0.9))
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .padding(.top)
                }
    }

    private func onClick() {
        UIApplication.shared.endEditing()

        let validationResult = checkValid(
                cardNumber: viewModel.cardNumberText,
                dateExpired: viewModel.dateExpiredText,
                cvv: viewModel.cvvText
        )

        if (validationResult.errorCardNumber == nil
                && validationResult.errorCvv == nil
                && validationResult.errorDateExpired == nil
           ) {
            viewModel.changeErrorState()
            viewModel.isLoading = true

            var card = viewModel.cardNumberText
            card = card.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)

            Task {
                await getCardsBankService(
                        pan: card,
                        next: {
                            startPaymentProcessing(
                                    isLoading: { isLoading in
                                        viewModel.isLoading = isLoading
                                    },
                                    saveCard: viewModel.switchSaveCard,
                                    cardNumber: viewModel.cardNumberText,
                                    dateExpired: viewModel.dateExpiredText,
                                    cvv: viewModel.cvvText,
                                    navigateCoordinator: navigateCoordinator
                            )
                        },
                        isLoading: { isLoading in
                            viewModel.isLoading = isLoading
                        }
                )
            }

        } else {
            viewModel.isLoading = false
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

