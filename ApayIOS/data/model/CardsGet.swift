//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation

//class CardsGetResponse : ArrayList<BankCard>()

internal struct BankCard {
    var pan: String? = nil
    var accountId: String? = nil// account_id
    var maskedPan: String? = nil// masked_pan
    var expiry: String? = nil //
    var expiredForResponse: String? = nil //expire
    var name: String? = nil
    var id: String? = nil
    var type: String? = nil
    var issuer: String? = nil
    var cvv: String? = nil

    var typeIcon: Int? = nil

    func getMaskedPanCleared()-> String {
        String(maskedPan?.suffix(6) ?? "")
    }
}