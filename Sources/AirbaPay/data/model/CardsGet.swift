//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation

public struct BankCard: Codable {
    public var pan: String? = nil
    public var accountId: String? = nil
    public var maskedPan: String? = nil
    public var expiry: String? = nil
    public var expiredForResponse: String? = nil
    public var name: String? = nil
    public var id: String? = nil
    public var type: String? = nil
    public var issuer: String? = nil
    public var cvv: String? = nil

    public var typeIcon: String? = nil

    public func getMaskedPanCleared()-> String {
        return String(maskedPan?.suffix(6) ?? "")
    }

    public func getMaskedPanClearedWithPoint()-> String {
        let text = maskedPan?.suffix(6) ?? ""
        let replaced = text.replacingOccurrences(of: "*", with: "•", options: .literal, range: nil)
        return String(replaced)
    }

    public func getExpiredCleared() -> String {
        let text = expiredForResponse?.prefix(7) ?? ""
        let replaced = text.dropFirst(2).replacingOccurrences(of: "-", with: "", options: .literal, range: nil)
        let result = replaced.suffix(2) + replaced.prefix(2)
        return String(result)
    }

    public enum CodingKeys: String, CodingKey {
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
