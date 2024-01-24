//
//  GetCvvResponse.swift
//
//  Created by Mikhail Belikov on 24.01.2024.
//

import Foundation

struct GetCvvResponse: Codable {

    var requestCvv: Bool?

    enum CodingKeys: String, CodingKey {
        case requestCvv = "request_cvv"
    }
}

