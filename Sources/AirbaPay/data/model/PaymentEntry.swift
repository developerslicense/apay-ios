//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation

struct PaymentEntryRequest: Encodable {
    var cardSave: Bool
    var email: String?
    var sendReceipt: Bool
    var card: BankCard?

    enum CodingKeys: String, CodingKey {
        case cardSave = "card_save"
        case email = "email"
        case sendReceipt = "send_receipt"
        case card = "card"
    }
}

struct PaymentEntryResponse: Decodable {
    var secure3D: Secure3D?
    var errorCode: Int?
    var errorMessage: String?
    var isRetry: Bool?  //если true то можно через кнопку "повторить"
    var isSecure3D: Bool?

    enum CodingKeys: String, CodingKey {
        case secure3D = "secure3D"
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case isRetry = "is_retry"
        case isSecure3D = "is_secure3D"
    }
}
