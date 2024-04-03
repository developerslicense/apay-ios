//
//  LogglyResponse.swift
//
//  Created by Mikhail Belikov on 28.03.2024.
//

import Foundation

struct LogglyRequest: Codable {

    var message: String?

    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}

struct LogglyResponse: Codable {

    var response: String? = nil

    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}
