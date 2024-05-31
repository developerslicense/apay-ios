//
//  ApiLogEntry.swift
//
//  Created by Mikhail Belikov on 28.03.2024.
//

import Foundation
import UIKit

struct ApiLogEntry: Codable {
    var url: String? = nil
    var method: String? = nil
    var responseCode: String? = nil

    var bodyParams: String? = nil
    var response: String? = nil
    var messages: String? = nil

    var platform: String = "iOS"
    var phone: String? = DataHolder.userPhone
    var time: String? = getCurrentDateFormatted()

    var osVersion: String? = "iOS " + UIDevice.current.systemVersion
    var sdkVersion: String? = DataHolder.sdkVersion
    var page: String? = LoggerHelper.getPageName()

    var orderNumber: String? = DataHolder.orderNumber

    var invoiceId: String? = DataHolder.invoiceId
    var env: String? = DataHolder.isProd ? "PROD" : "TEST"


    enum CodingKeys: String, CodingKey {
        case url = "url"
        case method = "method"
        case responseCode = "response_code"

        case bodyParams = "body_params"
        case response = "response"
        case messages = "messages"

        case platform = "platform"
        case phone = "phone"
        case time = "time"

        case osVersion = "os_version"
        case sdkVersion = "SDK_version"
        case page = "page"

        case orderNumber = "orderNumber"

        case invoiceId = "invoiceId"
        case env = "env"
    }
}
