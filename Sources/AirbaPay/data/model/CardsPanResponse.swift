//
// Created by Mikhail Belikov on 31.08.2023.
//

import Foundation

struct CardsPanResponse: Decodable {
    let bankCode: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case bankCode = "bank_code"
        case type = "type"
    }
}