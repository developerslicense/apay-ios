//
//  MerchantsResponse.swift
//
//  Created by Mikhail Belikov on 02.02.2024.
//

import Foundation

struct MerchantsResponse: Codable {
    
    var configuration: Configuration? = nil

    enum CodingKeys: String, CodingKey {
        case configuration = "configuration"
    }
}

struct Configuration: Codable {
    
    var saveCard: Bool? = nil
    var renderSaveCards: Bool? = nil
    var renderApplePayButton: Bool? = nil

    enum CodingKeys: String, CodingKey {
        case saveCard = "save_card"
        case renderSaveCards = "render_save_cards"
        case renderApplePayButton = "render_apple_pay_button"
    }
}

