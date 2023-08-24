//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct HomePage: View {
    @State var showDialogExit: Bool = false
    @State var switchSaveCard: Bool = false


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

                    SwitchedView(
                            text: saveCardData(),
                            switchCheckedState: switchSaveCard
                    ).padding(.top, 24)


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
    }
}


/*
    val scaffoldState: ScaffoldState = rememberScaffoldState()

    val isLoading = remember { mutableStateOf(true) }
    val showDialogExit = remember { mutableStateOf(false) }
    val switchSaveCard = remember { mutableStateOf(false) }

    val cardNumberFocusRequester = FocusRequester()
    val dateExpiredFocusRequester = FocusRequester()
    val cvvFocusRequester = FocusRequester()

    val cardNumberText = remember { mutableStateOf(TextFieldValue("")) }
    val dateExpiredText = remember { mutableStateOf(TextFieldValue("")) }
    val cvvText = remember { mutableStateOf(TextFieldValue("")) }

    val cardNumberError = remember { mutableStateOf<String?>(null) }
    val dateExpiredError = remember { mutableStateOf<String?>(null) }
    val cvvError = remember { mutableStateOf<String?>(null) }
    val emailError = remember { mutableStateOf<String?>(null) }

    val focusManager = LocalFocusManager.current

    val sheetState = rememberModalBottomSheetState(
        initialValue = ModalBottomSheetValue.Hidden,
        confirmValueChange = { it != ModalBottomSheetValue.HalfExpanded },
    )

    val purchaseAmount = DataHolder.purchaseAmountFormatted.collectAsState()

    BackHandler {
        coroutineScope.launch {
            if (sheetState.isVisible) sheetState.hide()
            else showDialogExit.value = true
        }
    }

    Scaffold(
        scaffoldState = scaffoldState
    ) { padding ->
        ModalBottomSheetLayout(
            sheetState = sheetState,
            sheetBackgroundColor = ColorsSdk.transparent,
            sheetContent = {
                CvvBottomSheet {
                    coroutineScope.launch { sheetState.hide() }
                }
            },
            modifier = Modifier.fillMaxSize()
        ) {




                    Spacer(modifier = Modifier.height(16.dp))
                    CardNumberView(
                        cardNumberText = cardNumberText,
                        cardNumberError = cardNumberError,
                        cardNumberFocusRequester = cardNumberFocusRequester,
                        dateExpiredFocusRequester = dateExpiredFocusRequester
                    )

                    Spacer(modifier = Modifier.height(16.dp))
                    Row(
                        modifier = Modifier
                            .padding(start = 16.dp, end = 16.dp)
                            .fillMaxWidth()
                    ) {
                        DateExpiredView(
                            dateExpiredFocusRequester = dateExpiredFocusRequester,
                            dateExpiredError = dateExpiredError,
                            dateExpiredText = dateExpiredText,
                            cvvFocusRequester = cvvFocusRequester,
                            modifier = Modifier
                                .weight(0.5f)
                                .padding(end = 6.dp)
                        )
                        CvvView(
                            cvvError = cvvError,
                            cvvFocusRequester = cvvFocusRequester,
                            cvvText = cvvText,
                            actionClickInfo = {
                                coroutineScope.launch {
                                    sheetState.show()
                                }
                            },
                            modifier = Modifier
                                .weight(0.5f)
                                .padding(start = 6.dp)
                        )
                    }


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

            if (switchSaveCard.value) {
                LaunchedEffect("snackBar") {
                    scaffoldState.snackbarHostState.showSnackbar(
                        message = cardDataSaved(),
                        actionLabel = null
                    )
                }
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