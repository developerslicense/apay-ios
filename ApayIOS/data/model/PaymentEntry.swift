//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation


internal struct PaymentEntryRequest {
    var cardSave: Bool // card_save
    var email: String?
    var sendReceipt: Bool//send_receipt
    var card: BankCard
}

internal struct PaymentEntryResponse {
    var secure3D: Secure3D?
    var errorCode: String? //error_code
    var errorMessage: String? //error_message
    var isRetry: Bool? // is_retry  //если true то можно через кнопку "повторить"
    var isSecure3D: Bool?  //is_secure3D
}
