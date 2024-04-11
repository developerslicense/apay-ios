//
//  LogglyResponse.swift
//
//  Created by Mikhail Belikov on 28.03.2024.
//

import Foundation

struct LogglyRequest: Codable {

    var request: ApiLogEntry?

    enum CodingKeys: String, CodingKey {
        case request = "message"
    }
}

struct LogglyResponse: Codable {

    var response: String? = nil

    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}
