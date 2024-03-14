//
// Created by Mikhail Belikov on 16.08.2023.
//

import Foundation

class DataHolder {
    static var sdkVersion = "1.0.63"
    static var baseUrl = ""

    static var connectTimeout = 60
    static var receiveTimeout = 60
    static var sendTimeout = 60

    static var isProd = true
    static var enabledLogsForProd = false

    static var bankCode: String? = nil
    static var accessToken: String? = nil
    static var cardId: String? = nil
    static var purchaseAmount = ""
    static var orderNumber = ""
    static var invoiceId = ""
    static var shopId = ""
    static var userEmail: String? = nil
    static var accountId = ""
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

    static var moduleBundle: Bundle?
            = Bundle.module /** в случае, если переносишь код в приложение, указывай Bundle.main*/

    static var redirectToCustomSuccessPage: (() -> Void)? = nil
    static var featureApplePay: Bool = false
    static var featureSavedCards: Bool = false

    static var applePayButtonUrl: String? = nil
    static var isApplePayFlow: Bool = true
    static var isExternalApplePayFlow: Bool = false
    static var hasSavedCards: Bool = false
    static var autoCharge: Int = 0
}

public class TestAirbaPayStates {
    public static var shutDownTestFeatureApplePay: Bool = false
    public static var shutDownTestFeatureSavedCards: Bool = false
}
