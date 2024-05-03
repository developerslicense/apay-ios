//
// Created by Mikhail Belikov on 16.08.2023.
//

import Foundation
import SwiftUI

public class AirbaPaySdk {
    // todo возможно, когда-нибудь можно будет переделать на это
    //   https://anuragajwani.medium.com/how-to-build-universal-ios-frameworks-using-xcframeworks-4c2790cfa623
    //   и можно будет избавиться от боли с тестированием правок
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
            needDisableScreenShot: Bool = false
    ) {

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
    }

}
