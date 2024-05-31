//
//  ApplePaymentWalletRequest.swift
//
//  Created by Mikhail Belikov on 27.02.2024.
//

import Foundation

struct ApplePaymentWalletRequest: Codable {

    var wallet: ApplePaymentWallet?

    let sendReceipt: Bool = DataHolder.userEmail != nil
    var email: String? = DataHolder.userEmail
    var params: PaymentParamsRequest = PaymentParamsRequest()

    enum CodingKeys: String, CodingKey {
        case sendReceipt = "send_receipt"
        case wallet = "wallet"
        case email = "email"
        case params = "params"
    }
}


struct ApplePaymentWallet: Codable {

    var token: String?
    var type: String = "ApplePay"

    enum CodingKeys: String, CodingKey {
        case token = "token"
        case type = "type"
    }
}
