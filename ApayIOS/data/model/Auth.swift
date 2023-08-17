//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation

internal struct AuthRequest {
    var password: String?
    var paymentId: String? //payment_id
    var terminalId: String? //terminal_id
    var user: String?
}

internal struct AuthResponse {
    var accessToken: String? //access_token
}