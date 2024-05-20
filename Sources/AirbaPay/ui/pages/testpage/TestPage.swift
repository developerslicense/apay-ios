import Foundation
import SwiftUI

private let ACCOUNT_ID_TEST = "77061111112"

struct TestPageAPSDK: View {
    @State var autoCharge: Bool = false
    @State var enabledFeatureApplePay: Bool = true
    @State var enabledFeatureSavedCards: Bool = true
    @State var featureCustomPages: Bool = false
    @State var isLoading: Bool = false
    @State var nativeApplePay: Bool = true
    @State var needDisableScreenShot: Bool = false

    var body: some View {

        ZStack {
            ColorsSdk.bgBlock

            ScrollView {
                VStack(alignment: .center) {
                    Text("Тестовые карты \n 4111 1111 1111 1616 cvv 333 \n 4111 1111 1111 1111 cvv 123 \n 3411 1111 1111 111 cvv 7777")
                            .padding(16)
                            .foregroundColor(.black)

                    Button(
                            action: {

                                let airbaPaySdk = testInitSdk(
                                        autoCharge: autoCharge ? 1 : 0,
                                        featureCustomPages: featureCustomPages,
                                        nativeApplePay: nativeApplePay,
                                        needDisableScreenShot: needDisableScreenShot,
                                        manualDisableFeatureApplePay: !enabledFeatureApplePay,
                                        manualDisableisableFeatureSavedCards: !enabledFeatureSavedCards
                                )

                                airbaPaySdk.startProcessing()
                            },
                            label: {
                                Text("Стандартный флоу")
                                        .font(.system(size: 16))
                                        .padding(16)

                            }
                    )

                    Button(
                            action: {
                                let airbaPaySdk = testInitSdk(
                                        autoCharge: autoCharge ? 1 : 0,
                                        featureCustomPages: featureCustomPages,
                                        nativeApplePay: nativeApplePay,
                                        needDisableScreenShot: needDisableScreenShot,
                                        manualDisableFeatureApplePay: !enabledFeatureApplePay,
                                        manualDisableisableFeatureSavedCards: !enabledFeatureSavedCards
                                )
                                airbaPaySdk.navigateCoordinator.openPage(content: TestSwiftUiApplePayPage(airbaPaySdk: airbaPaySdk))
                            },
                            label: {
                                Text("Тест внешнего API applePay ")
                                        .font(.system(size: 16))
                                        .padding(16)

                            }
                    )

                    Button(
                            action: {
                                let airbaPaySdk = testInitSdk(
                                        autoCharge: autoCharge ? 1 : 0,
                                        featureCustomPages: featureCustomPages,
                                        nativeApplePay: nativeApplePay,
                                        needDisableScreenShot: needDisableScreenShot,
                                        manualDisableFeatureApplePay: !enabledFeatureApplePay,
                                        manualDisableisableFeatureSavedCards: !enabledFeatureSavedCards
                                )

                                airbaPaySdk.navigateCoordinator.openPage(content: TestCardsPagee(airbaPaySdk: airbaPaySdk))

                            },
                            label: {
                                Text("Тест внешнего API сохраненных карт")
                                        .font(.system(size: 16))
                                        .padding(16)

                            }
                    )

                    Button(
                            action: {
                                let _ = testInitSdk(
                                        autoCharge: autoCharge ? 1 : 0,
                                        featureCustomPages: featureCustomPages,
                                        nativeApplePay: nativeApplePay,
                                        needDisableScreenShot: needDisableScreenShot,
                                        manualDisableFeatureApplePay: !enabledFeatureApplePay,
                                        manualDisableisableFeatureSavedCards: !enabledFeatureSavedCards
                                )
                                testDelCards(
                                        accountId: ACCOUNT_ID_TEST
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
                            text: "Есть Сохраненные карты",
                            switchCheckedState: enabledFeatureSavedCards,
                            actionOnChanged: { b in
                                enabledFeatureSavedCards = b
                            }
                    ).padding(8)

                    SwitchedView(
                            text: "Есть ApplePay",
                            switchCheckedState: enabledFeatureApplePay,
                            actionOnChanged: { b in
                                enabledFeatureApplePay = b
                            }
                    ).padding(8)

                    SwitchedView(
                            text: "Нативный ApplePay",
                            switchCheckedState: nativeApplePay,
                            actionOnChanged: { b in
                                nativeApplePay = b
                            }
                    ).padding(8)


                    SwitchedView(
                            text: "Кастомная страница Успеха от разработчика",
                            switchCheckedState: featureCustomPages,
                            actionOnChanged: { b in
                                featureCustomPages = b
                            }
                    ).padding(8)

                    SwitchedView(
                            text: "Блокировать скриншот",
                            switchCheckedState: needDisableScreenShot,
                            actionOnChanged: { b in
                                needDisableScreenShot = b
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
        featureCustomPages: Bool,
        nativeApplePay: Bool,
        needDisableScreenShot: Bool,
        manualDisableFeatureApplePay: Bool,
        manualDisableisableFeatureSavedCards: Bool
) -> AirbaPaySdk {

    DataHolder.hasSavedCards = false

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

    let airbaPaySdk = AirbaPaySdk.initSdk(
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
            isApplePayNative: nativeApplePay,
            shopName: "Technodom",
            applePayMerchantId:  "merchant.kz.airbapay.spf", //"merchant.kz.airbapay.pf" : "merchant.kz.airbapay.spf"
            needDisableScreenShot: needDisableScreenShot,
            actionOnCloseProcessing: { (b, navigation ) in // возврат в приложение из дефолтных страниц сдк (т.е., исключая кастомные)
                let navigateCoordinator = AirbaPayCoordinator()
                navigateCoordinator.openPage(content: TestPageAPSDK())
//                navigation.popToRootViewController(animated: true)

            },
            openCustomPageSuccess: featureCustomPages ? {
                let navigateCoordinator = AirbaPayCoordinator()
                let newVC = UIHostingController(rootView: CustomSuccessPage(navigateCoordinator: navigateCoordinator))

                navigateCoordinator.navigationController?.setToolbarHidden(true, animated: false)
                navigateCoordinator.navigationController?.setNavigationBarHidden(true, animated: false)
                navigateCoordinator.navigationController?.toolbar?.isHidden = true
                navigateCoordinator.navigationController?.pushViewController(newVC, animated: false)

            } : nil,
            openCustomPageFinalError: featureCustomPages ? {
                let navigateCoordinator = AirbaPayCoordinator()
                let newVC = UIHostingController(rootView: CustomErrorPage(navigateCoordinator: navigateCoordinator))

                navigateCoordinator.navigationController?.setToolbarHidden(true, animated: false)
                navigateCoordinator.navigationController?.setNavigationBarHidden(true, animated: false)
                navigateCoordinator.navigationController?.toolbar?.isHidden = true
                navigateCoordinator.navigationController?.pushViewController(newVC, animated: false)

            } : nil,
            manualDisableFeatureApplePay: manualDisableFeatureApplePay,
            manualDisableisableFeatureSavedCards: manualDisableisableFeatureSavedCards

    )


    return airbaPaySdk
}

struct CustomSuccessPage: View {
    var navigateCoordinator: AirbaPayCoordinator

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgBlock

            Button(
                    action: {
                        navigateCoordinator.openPage(content: TestPageAPSDK())
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
                        navigateCoordinator.openPage(content: TestPageAPSDK())
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
