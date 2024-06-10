import Foundation
import SwiftUI
import SimpleToast
import WebKit


private let ACCOUNT_ID_TEST = "77061111112"

struct TestSettings {
    static var isRenderSecurityCvv: Bool? = nil
    static var isRenderSecurityBiometry: Bool? = nil
    static var isRenderSavedCards: Bool? = nil
    static var isRenderApplePay: Bool? = nil
}

struct TestPageAPSDK: View {


    @StateObject var editTextViewModel: CoreEditTextViewModel = CoreEditTextViewModel()

    @State var autoCharge: Bool = false

    @State var showDropdownRenderSecurityCvv: Bool = false
    @State var showDropdownRenderSecurityBiometry: Bool = false
    @State var showDropdownRenderSavedCards: Bool = false
    @State var showDropdownRenderApplePay: Bool = false

    @State var renderSecurityCvv: Bool? = TestSettings.isRenderSecurityCvv
    @State var renderSecurityBiometry: Bool? = TestSettings.isRenderSecurityBiometry
    @State var renderSavedCards: Bool? = TestSettings.isRenderSavedCards
    @State var renderApplePay: Bool? = TestSettings.isRenderApplePay

    @State var featureCustomPages: Bool = false

    @State var nativeApplePay: Bool = DataHolder.isApplePayNative
    @State var needDisableScreenShot: Bool = DataHolder.needDisableScreenShot

    @State var isLoading: Bool = false

    @State var errorToast: Bool = false
    @State var errorJwtToast: Bool = false

    private let applePayMerchantId = "merchant.kz.airbapay.spf" //"merchant.kz.airbapay.pf"

    private let toastOptions = SimpleToastOptions(
            alignment: .bottom,
            hideAfter: 5
    )

    var body: some View {

        ZStack {
            ColorsSdk.bgBlock

            ScrollView {
                VStack(alignment: .center) {

                    Button(
                            action: {
                                UIApplication.shared.endEditing()
                                let airbaPaySdk = testInitSdk(needDisableScreenShot: needDisableScreenShot)
                                isLoading = true

                                onStandardFlowPassword(
                                        airbaPaySdk: airbaPaySdk,
                                        autoCharge: autoCharge ? 1 : 0,
                                        isLoading: { b in  },
                                        onSuccess: { token in
                                            isLoading = false
                                            Task {
                                                if let cards = await getCardsService(accountId: ACCOUNT_ID_TEST) {
                                                    var index = 0

                                                    while index < cards.count {
                                                        let _ = await deleteCardsService(cardId: cards[index].id ?? "")
                                                        index = index + 1
                                                    }
                                                }
                                            }
                                        },
                                        showError: {
                                            isLoading = false
                                            withAnimation { errorToast.toggle() }
                                        }

                                )
                            },
                            label: {
                                Text("Удалить привязанные карты")
                                        .font(.system(size: 16))
                                        .padding(16)

                            }
                    )


                    Text("Номера тестовых карт, которые можно использовать " +
                            "\n 4111 1111 1111 1616 cvv 333 " +
                            "\n 4111 1111 1111 1111 cvv 123 " +
                            "\n 3411 1111 1111 111 cvv 7777"
                    )
                            .padding(16)
                            .foregroundColor(.black)


                    Button(
                            action: {
                                UIApplication.shared.endEditing()
                                isLoading = true

                                let airbaPaySdk = testInitSdk(
                                        needDisableScreenShot: needDisableScreenShot,
                                        featureCustomPages: featureCustomPages
                                )

                                onStandardFlowPassword(
                                        airbaPaySdk: airbaPaySdk,
                                        autoCharge: autoCharge ? 1 : 0,
                                        isLoading: { b in  },
                                        onSuccess: { token in
                                            isLoading = false
                                            airbaPaySdk.standardFlow(
                                                    isApplePayNative: nativeApplePay,
                                                    applePayMerchantId: applePayMerchantId,
                                                    shopName: "Shop Name"
                                            )
                                        },
                                        showError: {
                                            isLoading = false
                                            withAnimation { errorToast.toggle() }
                                        }

                                )
                            },
                            label: {
                                Text("Стандартный флоу PASSWORD")
                                        .font(.system(size: 16))
                                        .padding(16)

                            }
                    )

                    Button(
                            action: {
                                UIApplication.shared.endEditing()
                                let airbaPaySdk = testInitSdk(needDisableScreenShot: needDisableScreenShot)
                                onStandardFlowPassword(
                                        airbaPaySdk: airbaPaySdk,
                                        autoCharge: autoCharge ? 1 : 0,
                                        isLoading: { b in  },
                                        onSuccess: { token in
                                            isLoading = false
                                            airbaPaySdk.navigateCoordinator.openPage(content: TestSwiftUiApplePayPage(airbaPaySdk: airbaPaySdk))
                                        },
                                        showError: {
                                            isLoading = false
                                            withAnimation { errorToast.toggle() }
                                        }
                                )
                            },
                            label: {
                                Text("Тест внешнего API ApplePay PASSWORD")
                                        .font(.system(size: 16))
                                        .padding(16)

                            }
                    )

                    Button(
                            action: {
                                UIApplication.shared.endEditing()
                                let airbaPaySdk = testInitSdk(needDisableScreenShot: needDisableScreenShot)
                                onStandardFlowPassword(
                                        airbaPaySdk: airbaPaySdk,
                                        autoCharge: autoCharge ? 1 : 0,
                                        isLoading: { b in  },
                                        onSuccess: { token in
                                            isLoading = false
                                            airbaPaySdk.navigateCoordinator.openPage(content: TestCardsPagee(airbaPaySdk: airbaPaySdk))
                                        },
                                        showError: {
                                            isLoading = false
                                            withAnimation { errorToast.toggle() }
                                        }
                                )


                            },
                            label: {
                                Text("Тест внешнего API сохраненных карт PASSWORD")
                                        .font(.system(size: 16))
                                        .padding(16)

                            }
                    )

                    Button(
                            action: {
                                UIApplication.shared.endEditing()
                                let airbaPaySdk = testInitSdk(needDisableScreenShot: needDisableScreenShot)
                                onStandardFlowPassword(
                                        airbaPaySdk: airbaPaySdk,
                                        autoCharge: autoCharge ? 1 : 0,
                                        isLoading: { b in  },
                                        onSuccess: { token in
                                            airbaPaySdk.standardFlowWebView(
                                                    isLoadingComplete: { isLoading = false },
                                                    shouldOverrideUrlLoading: { obj in
                                                        if(obj.navAction.navigationType == .other) {
                                                            obj.decisionHandler(.allow)
                                                            return

                                                        } else {

                                                            if obj.isCallbackSuccess {
                                                                airbaPaySdk.navigateCoordinator.openSuccess()

                                                            } else if obj.isCallbackBackToApp {
                                                                airbaPaySdk.navigateCoordinator.backToApp()

                                                            } else {
                                                                obj.decisionHandler(.allow)
                                                                return
                                                            }

                                                        }

                                                        obj.decisionHandler(.allow)

                                                    },
                                                    onError: { withAnimation { errorToast.toggle() }}
                                            )
                                        },
                                        showError: {
                                            isLoading = false
                                            withAnimation { errorToast.toggle() }
                                        }
                                )


                            },
                            label: {
                                Text("Стандартный флоу через вебвью")
                                        .font(.system(size: 16))
                                        .padding(16)

                            }
                    )

                    Text(
                            "Все нижние варианты требуют предварительно сгенерировать " +
                                    "или вставить JWT в поле ввода. " +
                                    "\nМожно сгенерировать, скопировать, " +
                                    "'убить' приложение, занова запустить и вставить из буффера"
                    )
                            .padding(.top, 30)
                            .padding(16)
                            .foregroundColor(.black)


                    ViewEditText(
                            viewModel: editTextViewModel,
                            errorTitle: nil,
                            placeholder: "JWT",
                            isText: true,
                            keyboardType: .default,
                            actionOnTextChanged: { text in
                                editTextViewModel.text = text
                            }
                    )
                            .padding(16)


                    Button(
                            action: {
                                UIApplication.shared.endEditing()
                                isLoading = true

                                let airbaPaySdk = testInitSdk(needDisableScreenShot: needDisableScreenShot)

                                onStandardFlowPassword(
                                        airbaPaySdk: airbaPaySdk,
                                        autoCharge: autoCharge ? 1 : 0,
                                        isLoading: { b in  },
                                        onSuccess: { token in
                                            editTextViewModel.text = token
                                            DataHolder.token = nil
                                            isLoading = false
                                        },
                                        showError: {
                                            isLoading = false
                                            withAnimation { errorToast.toggle() }
                                        }

                                )

                            },
                            label: {
                                Text("Сгенерировать JWT и вставить в поле ввода")
                                        .font(.system(size: 16))
                                        .padding(16)

                            }
                    )

                    Button(
                            action: {
                                UIApplication.shared.endEditing()
                                if editTextViewModel.text.isEmpty {
                                    withAnimation { errorJwtToast.toggle() }
                                } else {
                                    isLoading = true

                                    let airbaPaySdk = testInitSdk(needDisableScreenShot: needDisableScreenShot)

                                    airbaPaySdk.authJwt(
                                            jwt: editTextViewModel.text,
                                            onSuccess: {
                                                isLoading = false
                                                airbaPaySdk.standardFlow(
                                                        isApplePayNative: nativeApplePay,
                                                        applePayMerchantId: applePayMerchantId,
                                                        shopName: "Shop Name"
                                                )
                                            },
                                            onError:{
                                                isLoading = false
                                                withAnimation { errorToast.toggle() }
                                            }
                                    )
                                }
                            },
                            label: {
                                Text("Стандартный флоу JWT")
                                        .font(.system(size: 16))
                                        .padding(16)

                            }
                    )

                    Button(
                            action: {
                                UIApplication.shared.endEditing()
                                if editTextViewModel.text.isEmpty {
                                    withAnimation { errorJwtToast.toggle() }
                                } else {
                                    isLoading = true

                                    let airbaPaySdk = testInitSdk(needDisableScreenShot: needDisableScreenShot)

                                    airbaPaySdk.authJwt(
                                            jwt: editTextViewModel.text,
                                            onSuccess: {
                                                isLoading = false
                                                airbaPaySdk.navigateCoordinator.openPage(
                                                        content: TestSwiftUiApplePayPage(airbaPaySdk: airbaPaySdk)
                                                )
                                            },
                                            onError:{
                                                isLoading = false
                                                withAnimation { errorToast.toggle() }
                                            }
                                    )
                                }
                            },
                            label: {
                                Text("Тест внешнего API ApplePay JWT")
                                        .font(.system(size: 16))
                                        .padding(16)

                            }
                    )

                    Button(
                            action: {
                                if editTextViewModel.text.isEmpty {
                                    withAnimation { errorJwtToast.toggle() }
                                } else {
                                    isLoading = true

                                    let airbaPaySdk = testInitSdk(needDisableScreenShot: needDisableScreenShot)

                                    airbaPaySdk.authJwt(
                                            jwt: editTextViewModel.text,
                                            onSuccess: {
                                                isLoading = false
                                                airbaPaySdk.navigateCoordinator.openPage(
                                                        content: TestCardsPagee(airbaPaySdk: airbaPaySdk)
                                                )
                                            },
                                            onError:{
                                                isLoading = false
                                                withAnimation { errorToast.toggle() }
                                            }
                                    )
                                }
                            },
                            label: {
                                Text("Тест внешнего API сохраненных карт JWT")
                                        .font(.system(size: 16))
                                        .padding(16)

                            }
                    )

                    Text("Настройки только для Стандартного флоу")
                            .padding(.top, 30)
                            .padding(16)
                            .foregroundColor(.black)

                    DropdownList(
                            title1: "CVV - NULL",
                            title2: "CVV - FALSE",
                            title3: "CVV - TRUE",
                            showDropdown: showDropdownRenderSecurityCvv,
                            isRender: renderSecurityCvv,
                            onSelect: { b in
                                TestSettings.isRenderSecurityCvv = b
                            }
                    )
                    DropdownList(
                            title1: "Биометрия - NULL",
                            title2: "Биометрия - FALSE",
                            title3: "Биометрия - TRUE",
                            showDropdown: showDropdownRenderSecurityBiometry,
                            isRender: renderSecurityBiometry,
                            onSelect: { b in
                                TestSettings.isRenderSecurityBiometry = b
                            }
                    )
                    DropdownList(
                            title1: "Сохраненные карты - NULL",
                            title2: "Сохраненные карты - FALSE",
                            title3: "Сохраненные карты - TRUE",
                            showDropdown: showDropdownRenderSavedCards,
                            isRender: renderSavedCards,
                            onSelect: { b in
                                TestSettings.isRenderSavedCards = b
                            }
                    )
                    DropdownList(
                            title1: "ApplePay - NULL",
                            title2: "ApplePay - FALSE",
                            title3: "ApplePay - TRUE",
                            showDropdown: showDropdownRenderApplePay,
                            isRender: renderApplePay,
                            onSelect: { b in
                                TestSettings.isRenderApplePay = b
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
                            text: "Нативный ApplePay",
                            switchCheckedState: nativeApplePay,
                            actionOnChanged: { b in
                                nativeApplePay = b
                                DataHolder.isApplePayNative = b
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
                                DataHolder.needDisableScreenShot = needDisableScreenShot
                            }
                    ).padding(8)
                }
            }
                    .onTapGesture(perform: {
                        UIApplication.shared.endEditing()
                    })

                    .simpleToast(isPresented: $errorToast, options: toastOptions) {
                        Label("Что-то пошло не так", systemImage: "icAdd")
                                .padding()
                                .background(ColorsSdk.bgAccent.opacity(0.8))
                                .foregroundColor(ColorsSdk.bgBlock)
                                .cornerRadius(10)
                                .padding(.top)
                                .textStyleRegular()
                    }
                    .simpleToast(isPresented: $errorJwtToast, options: toastOptions) {
                        Label("Добавьте JWT в поле ввода", systemImage: "icAdd")
                                .padding()
                                .background(ColorsSdk.bgAccent.opacity(0.8))
                                .foregroundColor(ColorsSdk.bgBlock)
                                .cornerRadius(10)
                                .padding(.top)
                                .textStyleRegular()
                    }

            if isLoading {
                ColorsSdk.bgBlock
                ColorsSdk.bgBlock

                ProgressBarView()
            }
        }
    }
}

func onStandardFlowPassword(
        airbaPaySdk: AirbaPaySdk,
        autoCharge: Int = 0,
        invoiceId: String = String(Int(Date().timeIntervalSince1970)),
        isLoading: @escaping (Bool) -> Void,
        onSuccess: @escaping (String) -> Void,
        showError: @escaping () -> Void
) {
    isLoading(true)
    airbaPaySdk.authPassword(
            terminalId: "65c5df69e8037f1b451a0594",//"659e79e279a508566e35d299", //
            shopId: "test-baykanat", //"airbapay-mfo", //
            password: "baykanat123!", //"MtTh37TLV7", //
            onSuccess: { token in

                let someOrderNumber = Int(Date().timeIntervalSince1970)

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

                airbaPaySdk.createPayment(
                        authToken: token,
                        failureCallback: "https://site.kz/failure-clb",
                        successCallback: "https://site.kz/success-clb",
                        purchaseAmount: 1500.45,
                        accountId: "77061111112",
                        invoiceId: invoiceId,
                        orderNumber: String(someOrderNumber),
                        onSuccess: { result in
                            isLoading(false)
                            onSuccess(result.token ?? "")
                        },
                        onError: {
                            isLoading(false)
                            showError()
                        },
                        renderSecurityCvv: TestSettings.isRenderSecurityCvv,
                        renderSecurityBiometry: TestSettings.isRenderSecurityBiometry,
                        renderApplePay: TestSettings.isRenderApplePay,
                        renderSavedCards: TestSettings.isRenderSavedCards
//                goods = goods,
//                settlementPayments = settlementPayment
                )
            },
            onError: {
                isLoading(false)
                showError()
            }
    )
}

func testInitSdk(
        needDisableScreenShot: Bool = false,
        featureCustomPages: Bool = false
) -> AirbaPaySdk {

    DataHolder.hasSavedCards = false

    let airbaPaySdk = AirbaPaySdk.initSdk(
            isProd: false,
            lang: AirbaPaySdk.Lang.RU(),
            phone: ACCOUNT_ID_TEST,
            userEmail: "test@test.com",
            enabledLogsForProd: false,
            needDisableScreenShot: needDisableScreenShot,
            actionOnCloseProcessing: { (b, navigation ) in
                let navigateCoordinator = AirbaPayCoordinator()
                navigateCoordinator.openPage(content: TestPageAPSDK())
            },
            openCustomPageSuccess: featureCustomPages ? {
                let navigateCoordinator = AirbaPayCoordinator()
                let newVC = UIHostingController(rootView: CustomSuccessPage(navigateCoordinator: navigateCoordinator))

                navigateCoordinator.navigationController?.setToolbarHidden(true, animated: false)
                navigateCoordinator.navigationController?.setNavigationBarHidden(true, animated: false)
                navigateCoordinator.navigationController?.toolbar?.isHidden = true
                navigateCoordinator.navigationController?.pushViewController(newVC, animated: false)

            } : nil
    )


    return airbaPaySdk
}

struct DropdownList: View {
    var title1: String
    var title2: String
    var title3: String
    @State var showDropdown: Bool
    @State var isRender: Bool?
    var onSelect: (Bool?) -> Void

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgBlock

            VStack {
                Button(
                        action: {
                            showDropdown = !showDropdown
                        },
                        label: {
                            Text(isRender == nil ? title1 : isRender == false ? title2 : title3)
                                    .font(.system(size: 16))
                                    .padding(16)

                        }
                )
                        .frame(width: .infinity)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 50)

                if showDropdown {
                    Text(title1)
                            .textStyleSubtitleBold()
                            .frame(alignment: .center)
                            .padding(.top, 16)
                            .background(ColorsSdk.stateSuccess)
                            .onTapGesture {
                                showDropdown = false
                                isRender = nil
                                onSelect(nil)
                            }

                    Text(title2)
                            .textStyleSubtitleBold()
                            .frame(alignment: .center)
                            .padding(.top, 16)
                            .background(ColorsSdk.stateSuccess)
                            .onTapGesture {
                                showDropdown = false
                                isRender = false
                                onSelect(false)
                            }

                    Text(title3)
                            .textStyleSubtitleBold()
                            .frame(alignment: .center)
                            .padding(.top, 16)
                            .background(ColorsSdk.stateSuccess)
                            .onTapGesture {
                                showDropdown = false
                                isRender = true
                                onSelect(true)
                            }
                }
            }
        }
    }
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
