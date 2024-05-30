//
// Created by Mikhail Belikov on 16.08.2023.
//

import Foundation
import SwiftUI
import UIKit

public class AirbaPaySdk {
    // todo возможно, когда-нибудь можно будет переделать на это
    //   https://anuragajwani.medium.com/how-to-build-universal-ios-frameworks-using-xcframeworks-4c2790cfa623
    //   и можно будет избавиться от боли с тестированием правок

    var navigateCoordinator: AirbaPayCoordinator = AirbaPayCoordinator()
    var applePayViewModel: ApplePayViewModel = ApplePayViewModel()

    static var sdk: AirbaPaySdk? = nil

    public init() {}

    public enum Lang: Equatable {

        case RU(lang: String = "ru")
        case KZ(lang: String = "kz")
    }

    public struct Goods: Encodable {
        public init(
                brand: String,
                category: String,
                model: String,
                quantity: Int,
                price: Double
        ) {
            self.brand = brand
            self.category = category
            self.model = model
            self.quantity = quantity
            self.price = price
        }

        let brand: String // Брэнд продукта
        let category: String // Категория продукта
        let model: String // Модель продукта
        let quantity: Int // Количество в корзине
        let price: Double // Цена продукта
    }

    public struct SettlementPayment: Encodable {
        let amount: Double
        let companyId: String?

        public init(
                amount: Double,
                companyId: String?
        ) {
            self.amount = amount
            self.companyId = companyId
        }

        enum CodingKeys: String, CodingKey {
            case amount = "amount"
            case companyId = "company_id"
        }
    }

    public static func initSdk(
            isProd: Bool,
            lang: Lang,
            phone: String,
            userEmail: String?,
            colorBrandMain: Color? = nil,
            colorBrandInversion: Color? = nil,
            enabledLogsForProd: Bool = false,
            needDisableScreenShot: Bool = false,
            actionOnCloseProcessing: @escaping (Bool?, UINavigationController) -> Void,
            openCustomPageSuccess: (() -> Void)? = nil,
            openCustomPageFinalError: (() -> Void)? = nil
    ) -> AirbaPaySdk {

        let screenSize: CGRect = UIScreen.main.bounds

        DataHolder.height = Int(screenSize.height)
        DataHolder.width = Int(screenSize.width)

        if (colorBrandInversion != nil) {
            ColorsSdk.colorBrandInversion = colorBrandInversion!
        }

        if (colorBrandMain != nil) {
            ColorsSdk.colorBrandMain = colorBrandMain!
        }

        DataHolder.bankCode = nil
        DataHolder.token = nil
        DataHolder.isProd = isProd
        DataHolder.enabledLogsForProd = enabledLogsForProd

        if (DataHolder.isProd) {
            DataHolder.baseUrl = "https://ps.airbapay.kz/acquiring-api/sdk/"
        } else {
            DataHolder.baseUrl = "https://sps.airbapay.kz/acquiring-api/sdk/"
        }

        DataHolder.userPhone = phone
        DataHolder.userEmail = userEmail

        DataHolder.sendTimeout = 60
        DataHolder.connectTimeout = 60
        DataHolder.receiveTimeout = 60

        DataHolder.currentLang = lang
        DataHolder.needDisableScreenShot = needDisableScreenShot

        DataHolder.actionOnCloseProcessing = actionOnCloseProcessing
        DataHolder.openCustomPageSuccess = openCustomPageSuccess
        DataHolder.openCustomPageFinalError = openCustomPageFinalError

        sdk = AirbaPaySdk()

        return sdk!
    }

    // Navigations

    public func standardFlow(
            isApplePayNative: Bool,
            applePayMerchantId: String?,
            shopName: String = "Shop"
    ) {
        if DataHolder.token != nil {
            DataHolder.isApplePayNative = isApplePayNative
            DataHolder.applePayMerchantId = applePayMerchantId
            DataHolder.shopName = shopName

            navigateCoordinator.startProcessing()
        } else {
            print("AirbaPay. Нужно предварительно выполнить авторизацию и создание платежа")
        }
    }

    public func backToStartPage() {
        navigateCoordinator.backToStartPage()
    }

    public func backToApp(result: Bool = false) {
        navigateCoordinator.backToApp(result: result)
    }


    // Auth

    public func authPassword(
            terminalId: String,
            shopId: String,
            password: String,
            onSuccess: @escaping (String) -> Void,
            onError: @escaping () -> Void,
            paymentId: String? = nil
    ) {
        blAuth(
                navigateCoordinator: nil,
                password: password,
                terminalId: terminalId,
                shopId: shopId,
                onSuccess: onSuccess,
                onError: onError,
                paymentId: paymentId
        )
    }

    public func authJwt(
            jwt: String,
            onSuccess: @escaping () -> Void,
            onError: @escaping () -> Void
    ) {
        DataHolder.token = jwt
        blGetPaymentInfo(onSuccess: { r in onSuccess() }, onError: onError)
    }

    // Create payment

    public func createPayment(
            authToken: String,
            failureCallback: String,
            successCallback: String,
            purchaseAmount: Double,
            accountId: String,
            invoiceId: String,
            orderNumber: String,
            onSuccess: @escaping (String, String) -> Void,
            onError: @escaping () -> Void,
            renderSecurityCvv: Bool? = nil,
            renderSecurityBiometry: Bool? = nil,
            renderApplePay: Bool? = nil,
            renderSavedCards: Bool? = nil,
            autoCharge: Int = 0,
            goods: Array<Goods>? = nil,
            settlementPayments: Array<SettlementPayment>? = nil
    ) {
        DataHolder.accountId = accountId

        blCreatePayment(
                authToken: authToken,
                failureCallback: failureCallback,
                successCallback: successCallback,
                autoCharge: autoCharge,
                purchaseAmount: purchaseAmount,
                invoiceId: invoiceId,
                orderNumber: orderNumber,
                renderSecurityCvv: renderSecurityCvv,
                renderSecurityBiometry: renderSecurityBiometry,
                renderApplePay: renderApplePay,
                renderSavedCards: renderSavedCards,
                goods: goods,
                settlementPayments: settlementPayments,
                onSuccess: onSuccess,
                onError: onError
        )
    }

    // ApplePay

    public func processExternalApplePay(applePayToken: String) {
        AirbaPaySdk.sdk?.applePayViewModel.processingWallet(
                navigateCoordinator: self.navigateCoordinator,
                applePayToken: applePayToken
        )
    }

    // Cards

    public func getCards(
            onSuccess: @escaping ([BankCard]) -> Void,
            onNoCards: @escaping () -> Void
    ) {
        blGetSavedCards(onSuccess: onSuccess, onNoCards: onNoCards)
    }

    public func paySavedCard(
            bankCard: BankCard,
            isLoading: @escaping (Bool) -> Void,
            onError: @escaping () -> Void
    ) {
        blGetPaymentInfo(
                onSuccess: { r in
                    blCheckSavedCardNeedCvv(
                            navigateCoordinator: self.navigateCoordinator,
                            selectedCard: bankCard,
                            isLoading: isLoading,
                            onError: onError,
                            showCvv: { showBottomSheetEnterCvv(airbaPaySdk: self, selectedCard: bankCard)}
                    )
                },
                onError: {
                    self.navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
                }
        )
    }

    public func deleteCard(
            cardId: String,
            onSuccess: @escaping () -> Void,
            onError: @escaping () -> Void
    ) {
        blDeleteCard(cardId: cardId, onSuccess: onSuccess, onError: onError)
    }
}
