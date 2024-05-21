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
            accountId: String,
            phone: String,
            userEmail: String?,
            shopId: String,
            password: String,
            terminalId: String,
            failureCallback: String,
            successCallback: String,
            colorBrandMain: Color? = nil,
            colorBrandInversion: Color? = nil,
            autoCharge: Int = 0,
            enabledLogsForProd: Bool = false,
            purchaseAmount: Double,
            invoiceId: String,
            orderNumber: String,
            goods: Array<Goods>,
            settlementPayments: Array<SettlementPayment>? = nil,
            isApplePayNative: Bool = false,
            shopName: String = "Shop",
            applePayMerchantId: String? = nil,
            needDisableScreenShot: Bool = false,
            actionOnCloseProcessing: @escaping (Bool?, UINavigationController) -> Void,
            openCustomPageSuccess: (() -> Void)? = nil,
            openCustomPageFinalError: (() -> Void)? = nil,
            manualDisableFeatureApplePay: Bool = false,
            manualDisableisableFeatureSavedCards: Bool = false
    ) -> AirbaPaySdk {

        if (colorBrandInversion != nil) {
            ColorsSdk.colorBrandInversion = colorBrandInversion!
        }

        if (colorBrandMain != nil) {
            ColorsSdk.colorBrandMain = colorBrandMain!
        }

        DataHolder.bankCode = nil
        DataHolder.accessToken = nil
        DataHolder.isProd = isProd
        DataHolder.enabledLogsForProd = enabledLogsForProd

        if (DataHolder.isProd) {
            DataHolder.baseUrl = "https://ps.airbapay.kz/acquiring-api/sdk/"
        } else {
            DataHolder.baseUrl = "https://sps.airbapay.kz/acquiring-api/sdk/"
        }

        DataHolder.accountId = accountId
        DataHolder.userPhone = phone
        DataHolder.userEmail = userEmail

        DataHolder.failureCallback = failureCallback
        DataHolder.successCallback = successCallback

        DataHolder.sendTimeout = 60
        DataHolder.connectTimeout = 60
        DataHolder.receiveTimeout = 60
        DataHolder.shopId = shopId
        DataHolder.password = password
        DataHolder.terminalId = terminalId
        DataHolder.autoCharge = autoCharge

        DataHolder.currentLang = lang

        DataHolder.purchaseAmount = String(purchaseAmount)
        DataHolder.orderNumber = orderNumber
        DataHolder.invoiceId = invoiceId
        DataHolder.goods = goods
        DataHolder.settlementPayments = settlementPayments

        DataHolder.purchaseAmountFormatted = Money.initDouble(amount: purchaseAmount).getFormatted()

        DataHolder.isApplePayNative = isApplePayNative
        DataHolder.shopName = shopName
        DataHolder.applePayMerchantId = applePayMerchantId
        DataHolder.needDisableScreenShot = needDisableScreenShot

        DataHolder.actionOnCloseProcessing = actionOnCloseProcessing
        DataHolder.openCustomPageSuccess = openCustomPageSuccess
        DataHolder.openCustomPageFinalError = openCustomPageFinalError

        DataHolder.manualDisableFeatureApplePay = manualDisableFeatureApplePay
        DataHolder.manualDisableisableFeatureSavedCards = manualDisableisableFeatureSavedCards

        sdk = AirbaPaySdk()

        return sdk!
    }

    // Navigations

    public func startProcessing() {
        navigateCoordinator.startProcessing()
    }

    public func openHome() {
        navigateCoordinator.openHome()
    }

    public func backToStartPage() {
        navigateCoordinator.backToStartPage()
    }

    public func backToApp(result: Bool = false) {
        navigateCoordinator.backToApp(result: result)
    }

    public func openAcquiring(redirectUrl: String?) {
        navigateCoordinator.openAcquiring(redirectUrl: redirectUrl)
    }

    public func openSuccess() {
        navigateCoordinator.openSuccess()
    }

    public func openRepeat() {
        navigateCoordinator.openRepeat()
    }

    public func openErrorPageWithCondition(errorCode: Int?) {
        navigateCoordinator.openErrorPageWithCondition(errorCode: errorCode)
    }

    // External Api Auth

    public func auth(
            onSuccess: @escaping () -> Void,
            onError: @escaping () -> Void
    ) {
        blAuth(
                navigateCoordinator: nil,
                onSuccess: onSuccess,
                onError: onError,
                paymentId: nil
        )
    }

    // External Api create payment

//    public func initPayment(
//        onSuccess: @escaping () -> Void,
//        onError: @escaping () -> Void
//    ) {
//        blInitExternalPayments(onSuccess: onSuccess, onError: onError)
//    }

    // External Api Cards

    public func paySavedCard(
            needFaceId: Bool,
            bankCard: BankCard,
            isLoading: @escaping (Bool) -> Void,
            onError: @escaping () -> Void
    ) {
        blPaySavedCard(card: bankCard, isLoading: isLoading, onError: onError, needFaceId: needFaceId, airbaPaySdk: self)
    }

    public func getCards(
            onSuccess: @escaping ([BankCard]?) -> Void,
            onNoCards: @escaping () -> Void

    ) {
        blGetCards(onSuccess: onSuccess, onNoCards: onNoCards)
    }

    public func deleteCard(
            cardId: String,
            onSuccess: @escaping () -> Void,
            onError: @escaping () -> Void
    ) {
        blDeleteCard(cardId: cardId, onSuccess: onSuccess, onError: onError)
    }

    // External Api ApplePay

    public func processExternalApplePay(uiViewController: UIViewController? = nil) {
        uiViewController != nil ?
                blProcessExternalApplePay(uiViewController: uiViewController!) :
                blProcessExternalApplePay()

    }

}
