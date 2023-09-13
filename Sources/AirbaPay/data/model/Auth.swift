//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation
import Alamofire

struct AuthRequest: Encodable {
    var password: String?
    var paymentId: String?
    var terminalId: String?
    var user: String?

    enum CodingKeys: String, CodingKey {
        case password = "password"
        case paymentId = "payment_id"
        case terminalId = "terminal_id"
        case user = "user"
    }
}

struct AuthResponse: Decodable {
    var accessToken: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
