//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation

struct BankCard: Codable {
    var pan: String? = nil
    var accountId: String? = nil
    var maskedPan: String? = nil
    var expiry: String? = nil
    var expiredForResponse: String? = nil
    var name: String? = nil
    var id: String? = nil
    var type: String? = nil
    var issuer: String? = nil
    var cvv: String? = nil

    var typeIcon: String? = nil

    func getMaskedPanCleared()-> String {
        String(maskedPan?.suffix(6) ?? "")
    }

    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case maskedPan = "masked_pan"
        case expiredForResponse = "expire"
        case pan = "pan"
        case expiry = "expiry"
        case cvv = "cvv"
        case issuer = "issuer"
        case type = "type"
        case id = "id"
        case name = "name"
    }
}
