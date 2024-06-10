//
// Created by Mikhail Belikov on 16.08.2023.
//

import Foundation
import UIKit
import WebKit

class DataHolder {
    static var moduleBundle: Bundle?
            = Bundle.module /** в случае, если переносишь код в приложение, указывай Bundle.main*/

    static var sdkVersion = "2.1.1"
    static var baseUrl = ""

    static var connectTimeout = 60
    static var receiveTimeout = 60
    static var sendTimeout = 60

    static var isProd = true
    static var enabledLogsForProd = false

    static var purchaseAmount: Double = 0.0
    static var orderNumber: String? = nil
    static var invoiceId = ""

    static var bankCode: String? = nil
    static var token: String? = nil

    static var userEmail: String? = nil
    static var userPhone = ""
    static var accountId = ""
    static var shopName = "Shop"

    static var failureBackUrl = "https://site.kz/failure"
    static var successBackUrl = "https://site.kz/success"

    static var currentLang: AirbaPaySdk.Lang = AirbaPaySdk.Lang.RU()

    static var purchaseAmountFormatted: String = ""
    static var purchaseNumber: String = ""

    static var actionOnCloseProcessing: ((Bool?, UINavigationController) -> Void)? = nil
    static var shouldOverrideUrlLoading: ((AirbaPaySdk.ShouldOverrideUrlLoading) -> Void)? = nil

    static var openCustomPageSuccess: (() -> Void)? = nil
    static var openCustomPageFinalError: (() -> Void)? = nil

    static var isApplePayFlow: Bool = true
    static var hasSavedCards: Bool = false

    static var needDisableScreenShot = false

    static var isApplePayNative: Bool = false

    public static var renderApplePay: Bool? = nil
    public static var renderSavedCards: Bool? = nil
    public static var renderSecurityCvv: Bool? = nil
    public static var renderSecurityBiometry: Bool? = nil

    public static var height: Int? = nil
    public static var width: Int? = nil

    public static func isRenderApplePay() -> Bool { return renderApplePay ?? true }
    public static func isRenderSavedCards() -> Bool { return renderSavedCards ?? true }
    public static func isRenderSecurityCvv() -> Bool { return renderSecurityCvv ?? true }
    public static func isRenderSecurityBiometry() -> Bool { return renderSecurityBiometry ?? true }

    static var applePayMerchantId: String? = nil
    static var applePayButtonUrl: String? = nil

}


