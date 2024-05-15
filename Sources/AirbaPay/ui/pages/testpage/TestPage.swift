import Foundation
import SwiftUI

private let ACCOUNT_ID_TEST = "77061111112"

struct TestPageAPSDK: View {
    @State var autoCharge: Bool = false
    @State var featureApplePay: Bool = true
    @State var featureSavedCards: Bool = true
    @State var featureCustomPages: Bool = false
    @State var isLoading: Bool = false

    var navigateCoordinator: AirbaPayCoordinator

    var body: some View {
//        let applePay = ApplePayManager(navigateCoordinator: navigateCoordinator)

        ZStack {
            ColorsSdk.bgBlock

            ScrollView {
                VStack(alignment: .center) {
                    Text("Тестовые карты \n 4111 1111 1111 1616 cvv 333 \n 4111 1111 1111 1111 cvv 123 \n 3411 1111 1111 111 cvv 7777")
                            .padding(16)
                            .foregroundColor(.black)

                    Button(
                            action: {
                                DataHolder.hasSavedCards = false

                                TestAirbaPayStates.shutDownTestFeatureApplePay = !featureApplePay
                                TestAirbaPayStates.shutDownTestFeatureSavedCards = !featureSavedCards

                                testInitSdk(
                                        autoCharge: autoCharge ? 1 : 0,
                                        navigateCoordinator: navigateCoordinator,
                                        openCustomPageSuccess: featureCustomPages ? {
                                            let newVC = UIHostingController(rootView: CustomSuccessPage(navigateCoordinator: navigateCoordinator))

                                            navigateCoordinator.navigationController?.setToolbarHidden(true, animated: false)
                                            navigateCoordinator.navigationController?.setNavigationBarHidden(true, animated: false)
                                            navigateCoordinator.navigationController?.toolbar?.isHidden = true
                                            navigateCoordinator.navigationController?.pushViewController(newVC, animated: false)

                                        } : nil,
                                        openCustomPageFinalError: featureCustomPages ? {
                                            let newVC = UIHostingController(rootView: CustomErrorPage(navigateCoordinator: navigateCoordinator))

                                            navigateCoordinator.navigationController?.setToolbarHidden(true, animated: false)
                                            navigateCoordinator.navigationController?.setNavigationBarHidden(true, animated: false)
                                            navigateCoordinator.navigationController?.toolbar?.isHidden = true
                                            navigateCoordinator.navigationController?.pushViewController(newVC, animated: false)

                                        } : nil
                                )

                                navigateCoordinator.startProcessing()
                            },
                            label: {
                                Text("Стандартный флоу")
                                        .font(.system(size: 16))
                                        .padding(16)

                            }
                    )

                    Button(
                            action: {
                                testInitSdk(autoCharge: autoCharge  ? 1 : 0, navigateCoordinator: navigateCoordinator)
                                //                                        navigateCoordinator.openTestApplePaySwiftUi()

                                //                                applePay.buyBtnTapped()

                            },
                            label: {
                                Text("Тест внешнего API applePay ")
                                        .font(.system(size: 16))
                                        .padding(16)

                            }
                    )

                    Button(
                            action: {
                                testInitSdk(autoCharge: autoCharge  ? 1 : 0, navigateCoordinator: navigateCoordinator)
                                //                                        navigateCoordinator.openTestApplePaySwiftUi()

                                //                                applePay.buyBtnTapped()

                            },
                            label: {
                                Text("Тест внешнего API сохраненных карт")
                                        .font(.system(size: 16))
                                        .padding(16)

                            }
                    )

                    Button(
                            action: {
                                testInitSdk(autoCharge: autoCharge  ? 1 : 0, navigateCoordinator: navigateCoordinator)
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



                    SwitchedView(
                            text: "AutoCharge 0 (off) / 1 (on)",
                            switchCheckedState: autoCharge,
                            actionOnChanged: { b in
                                autoCharge = b
                            }
                    ).padding(8)

                    SwitchedView(
                            text: "Feature ApplePay",
                            switchCheckedState: featureApplePay,
                            actionOnChanged: { b in
                                featureApplePay = b
                            }
                    ).padding(8)

                    SwitchedView(
                            text: "Feature Saved cards",
                            switchCheckedState: featureSavedCards,
                            actionOnChanged: { b in
                                featureSavedCards = b
                            }
                    ).padding(8)

                    SwitchedView(
                            text: "Feature Custom pages",
                            switchCheckedState: featureCustomPages,
                            actionOnChanged: { b in
                                featureCustomPages = b
                            }
                    ).padding(8)
                }
            }
            if isLoading {
                ProgressBarView()
            }
        }
    }
}


func testInitSdk(
        autoCharge: Int = 0,
        navigateCoordinator: AirbaPayCoordinator,
        openCustomPageSuccess: (() -> Void)? = nil,
        openCustomPageFinalError: (() -> Void)? = nil
) {
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
                price: 500.04
        )
    ]

    let settlementPayment = [
        AirbaPaySdk.SettlementPayment(
                amount: 1000,
                companyId: "210840019439"
        ),
        AirbaPaySdk.SettlementPayment(
                amount: 500.04,
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
            password: "baykanat123!", //"123456",
            terminalId: "65c5df69e8037f1b451a0594",//"64216e7ccc4a48db060dd689",
            failureCallback: "https://site.kz/failure-clb",
            successCallback: "https://site.kz/success-clb",
            //            colorBrandMain: Color.orange,
            autoCharge: autoCharge,
            enabledLogsForProd: false,
            purchaseAmount: 1500.04,
            invoiceId: String(someInvoiceId),
            orderNumber: String(someOrderNumber),
            goods: goods,
            settlementPayments: settlementPayment,
//            isApplePayNative: true,
            shopName: "Technodom",
            applePayMerchantId:  "merchant.kz.airbapay.spf", //"merchant.kz.airbapay.pf" : "merchant.kz.airbapay.spf"
//            needDisableScreenShot: true
            actionOnCloseProcessing: { b in // возврат в приложение из дефолтных страниц сдк (т.е., исключая кастомные)
                navigateCoordinator.openTestPage()
            },
            openCustomPageSuccess: openCustomPageSuccess,
            openCustomPageFinalError: openCustomPageFinalError

    )
}

struct CustomSuccessPage: View {
    var navigateCoordinator: AirbaPayCoordinator

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgBlock

            Button(
                    action: {
                        navigateCoordinator.openTestPage()
                    },
                    label: {
                        Text("Succes. BackToApp")
                                .font(.system(size: 16))
                                .padding(16)

                    }
            )
        }
    }
}

struct CustomErrorPage: View {
    var navigateCoordinator: AirbaPayCoordinator

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgBlock

            Button(
                    action: {
                        navigateCoordinator.openTestPage()
                    },
                    label: {
                        Text("Error. BackToApp")
                                .font(.system(size: 16))
                                .padding(16)

                    }
            )
        }
    }
}
