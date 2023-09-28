//
// Created by Mikhail Belikov on 26.09.2023.
//

import Foundation

struct ApplePayButtonResponse: Decodable {
    var buttonUrl: String?

    enum CodingKeys: String, CodingKey {
        case buttonUrl = "button_url"
    }
}