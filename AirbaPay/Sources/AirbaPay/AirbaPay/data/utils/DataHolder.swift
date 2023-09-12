//
// Created by Mikhail Belikov on 16.08.2023.
//

import Foundation

class DataHolder {
    static var baseUrl = ""

    static var connectTimeout = 60
    static var receiveTimeout = 60
    static var sendTimeout = 60

    static var isProd = true
    static var needShowSdkSuccessPage = true

    static var bankCode: String? = nil
    static var accessToken: String? = nil
    static var cardId: String? = nil
    static var purchaseAmount = ""
    static var orderNumber = ""
    static var invoiceId = ""
    static var shopId = ""
    static var userEmail: String? = nil
    static var userPhone = ""
    static var password = ""
    static var terminalId  = ""
    static var failureBackUrl = ""
    static var failureCallback = ""
    static var successBackUrl = ""
    static var successCallback = ""
    static var currentLang: AirbaPaySdk.Lang = AirbaPaySdk.Lang.RU()

    static var goods: Array<AirbaPaySdk.Goods>? = nil
    static var settlementPayments: Array<AirbaPaySdk.SettlementPayment>? = nil

    static var purchaseAmountFormatted: String = ""

    static var moduleBundle: Bundle? = Bundle.module
}
