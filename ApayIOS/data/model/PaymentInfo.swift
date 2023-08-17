//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation


internal struct PaymentInfoResponse {
    var secure3D: Secure3D?
    var card: BankCard?
    var cardSave: Bool? // card_save
    var isRetry: Bool? // is_retry
    var amount: Int?
    var errorCode: Int? //error_code
    var bankCode: String? // bank_code
    var cardId: String? // card_id
    var action: String?
    var created: String?
    var currency: String?
    var description: String?
    var email: String?
    var errorMessage: String? // error_message
    var expired: String?
    var successBackUrl: String? // success_back_url
    var failureBackUrl: String? // failure_back_url
    var id: String?
    var invoiceId: String? // invoice_id
    var language: String?
    var orderNumber: String? // order_number
    var phone: String?
    var status: String?
    var terminalId: String? // terminal_id
    var type: String?

}

internal struct Secure3D {
    var action: String?
    var md: String?
    var paReq: String? // pa_req
    var termUrl: String? // term_url

}