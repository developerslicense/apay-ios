//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation

struct PaymentCreateRequest: Encodable {
    var accountId: String?
    var invoiceId: String?
    var orderNumber: String?

    var language: String?
    var phone: String?
    var email: String?
    var failureBackUrl: String?

    var failureCallback: String?
    var successBackUrl: String?
    var successCallback: String?
    var amount: Double?

    var settlement: SettlementPaymentsRequest?
    var autoCharge: Int = 0
    var currency: String = "KZT"

    var description: String = "description"
    var cart: [AirbaPaySdk.Goods]

    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case invoiceId = "invoice_id"
        case orderNumber = "order_number"

        case language = "language"
        case email = "email"
        case phone = "phone"
        case failureBackUrl = "failure_back_url"

        case failureCallback = "failure_callback"
        case successBackUrl = "success_back_url"
        case successCallback = "success_callback"
        case amount = "amount"

        case settlement = "settlement"
        case autoCharge = "auto_charge"
        case currency = "currency"

        case description = "description"

    }
}

struct SettlementPaymentsRequest: Encodable {
    var payments: [AirbaPaySdk.SettlementPayment]
}

struct PaymentCreateResponse: Decodable {
    var invoiceId: String?
    var id: String?
    var status: String?
    var redirectURL: String?

    enum CodingKeys: String, CodingKey {
        case invoiceId = "invoice_id"
        case id = "id"
        case status = "status"
        case redirectURL = "redirectURL"
    }
}
