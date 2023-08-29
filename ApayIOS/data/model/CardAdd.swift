//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation

struct CardAddRequest {
    var language: String?
    var accountId: String? //account_id
    var email: String
    var phone: String?
    var failureBackUrl: String? //failure_back_url
    var failureCallback: String //failure_callback
    var successBackUrl: String? //success_back_url
    var successCallback: String? // success_callback

}

struct CardAddResponse {
    var cardId: String? //id
}

