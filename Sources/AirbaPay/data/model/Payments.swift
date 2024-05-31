//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation

struct PaymentDefaultRequest: Codable {
    var cardSave: Bool
    var email: String?
    var sendReceipt: Bool
    var card: BankCard?
    var params: PaymentParamsRequest = PaymentParamsRequest()


    enum CodingKeys: String, CodingKey {
        case cardSave = "card_save"
        case email = "email"
        case params = "params"
        case sendReceipt = "send_receipt"
        case card = "card"
    }
}

struct PaymentSavedCardRequest: Codable {
    var cvv: String
    var params: PaymentParamsRequest = PaymentParamsRequest()

    enum CodingKeys: String, CodingKey {
        case cvv = "cvv"
        case params = "params"
    }
}

struct PaymentParamsRequest: Codable {
    var screenHeight: Int? = DataHolder.height
    var screenWidth: Int? = DataHolder.width

    enum CodingKeys: String, CodingKey {
        case screenHeight = "screen_height"
        case screenWidth = "screen_width"
    }
}

struct PaymentEntryResponse: Decodable {
    var secure3D: Secure3D?
    var errorCode: Int?
    var errorMessage: String?
    var status: String?
    var accountId: String?
    var payformUrl: String?
    var invoiceId: String?
    var orderNumber: String?
    var failureBackUrl: String?
    var successBackUrl: String?
    var isRetry: Bool?  //если true то можно через кнопку "повторить"
    var isSecure3D: Bool?
    var amount: Double?
    var addParameters: AddParameters?

    enum CodingKeys: String, CodingKey {
        case secure3D = "secure3D"
        case errorCode = "error_code"
        case status = "status"
        case accountId = "account_id"
        case payformUrl = "payform_url"
        case errorMessage = "error_message"
        case isRetry = "is_retry"
        case isSecure3D = "is_secure3D"
        case orderNumber = "order_number"
        case amount = "amount"
        case failureBackUrl = "failure_back_url"
        case successBackUrl = "success_back_url"
        case invoiceId = "invoice_id"
        case addParameters = "add_parameters"
    }
}
