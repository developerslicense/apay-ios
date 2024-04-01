import Foundation
import SwiftUI
import PathPresenter

private let ACCOUNT_ID_TEST = "77061111112"

struct TestPage1: View {
    @State var autoCharge: Bool = false
    @State var featureApplePay: Bool = true
    @State var featureSavedCards: Bool = true
    @State var isLoading: Bool = false

    @ObservedObject var navigateCoordinator = AirbaPayCoordinator(
            isCustomSuccessPageView: true,
            isCustomFinalErrorPageView: true,
            //        actionOnOpenProcessing: { print("qqqqqq actionOnOpenProcessing")},
            actionOnCloseProcessing: { result in  print("qqqqqq  actionOnCloseProcessing" + String(result ?? false)) }

    )

    var body: some View {
        AirbaPayView(
                navigateCoordinator: navigateCoordinator,
                contentView: {

                    ZStack {
                        Color.white

                        VStack(alignment: .center) {
                            Text("Тестовые карты \n 4111 1111 1111 1616 cvv 333 \n 4111 1111 1111 1111 cvv 123 \n 3411 1111 1111 111 cvv 7777")
                                    .padding(16)

                            Button(
                                    action: {
                                        DataHolder.hasSavedCards = false

                                        TestAirbaPayStates.shutDownTestFeatureApplePay = !featureApplePay
                                        TestAirbaPayStates.shutDownTestFeatureSavedCards = !featureSavedCards

                                        testInitSdk(autoCharge: autoCharge ? 1 : 0)
                                        navigateCoordinator.startProcessing()
                                    },
                                    label: {
                                        Text("Переход на эквайринг")
                                                .font(.system(size: 16))
                                                .padding(16)

                                    }
                            )

                            Button(
                                    action: {
                                        testInitSdk(autoCharge: autoCharge  ? 1 : 0)
                                        testDelCards(
                                                accountId: ACCOUNT_ID_TEST,
                                                isLoading: { b in
                                                    isLoading = b
                                                }
                                        )
                                    },
                                    label: {
                                        Text("Удалить привязанные карты")
                                                .font(.system(size: 16))
                                                .padding(16)

                                    }
                            )

                            Button(
                                    action: {
                                        testInitSdk(autoCharge: autoCharge  ? 1 : 0)
                                        navigateCoordinator.openTestApplePaySwiftUi()
                                    },
                                    label: {
                                        Text("Тест внешнего applePay механизма")
                                                .font(.system(size: 16))
                                                .padding(16)

                                    }
                            )

                            SwitchedView(
                                    text: "AutoCharge 0 (off) / 1 (on)",
                                    switchCheckedState: autoCharge,
                                    actionOnChanged: { b in
                                        autoCharge = b
                                    }
                            ).padding(16)

                            SwitchedView(
                                    text: "Feature ApplePay",
                                    switchCheckedState: featureApplePay,
                                    actionOnChanged: { b in
                                        featureApplePay = b
                                    }
                            ).padding(16)

                            SwitchedView(
                                    text: "Feature Saved cards",
                                    switchCheckedState: featureSavedCards,
                                    actionOnChanged: { b in
                                        featureSavedCards = b
                                    }
                            ).padding(16)
                        }

                        if isLoading {
                            ProgressBarView()
                        }
                    }


                }
        )
    }
}


func testInitSdk(autoCharge: Int) {
    let someInvoiceId = Int(Date().timeIntervalSince1970)
    let someOrderNumber = Int(Date().timeIntervalSince1970)
    print("someOrderNumber" + String(someOrderNumber))
    print("someInvoiceId" + String(someInvoiceId))


    let goods = [
        AirbaPaySdk.Goods(
                brand: "Чай Tess Banana Split черный 20 пирамидок",
                category: "Tess",
                model: "Черный чай",
                quantity: 1,
                price: 1000
        ),
        AirbaPaySdk.Goods(
                brand: "Чай Tess Green",
                category: "Tess",
                model: "Green чай",
                quantity: 1,
                price: 500
        )
    ]

    let settlementPayment = [
        AirbaPaySdk.SettlementPayment(
                amount: 1000,
                companyId: "210840019439"
        ),
        AirbaPaySdk.SettlementPayment(
                amount: 500,
                companyId: "254353"
        )
    ]

    AirbaPaySdk.initSdk(
            isProd: false,
            lang: AirbaPaySdk.Lang.RU(),
            accountId: ACCOUNT_ID_TEST,
            phone: ACCOUNT_ID_TEST,
            userEmail: "test@test.com",
            shopId: "test-baykanat",//"test-merchant",
            password: "baykanat123!",//"123456",
            terminalId: "65c5df69e8037f1b451a0594",//"64216e7ccc4a48db060dd689",
            failureCallback: "https://site.kz/failure-clb",
            successCallback: "https://site.kz/success-clb",
            //            colorBrandMain: Color.orange,
            autoCharge: autoCharge,
            enabledLogsForProd: false,
            purchaseAmount: 1500,
            invoiceId: String(someInvoiceId),
            orderNumber: String(someOrderNumber),
            goods: goods,
            settlementPayments: settlementPayment
    )
}

