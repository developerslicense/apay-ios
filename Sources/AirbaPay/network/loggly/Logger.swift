//
//  Logger.swift
//
//  Created by Mikhail Belikov on 28.03.2024.
//

import Foundation

private let TAG = "TagAirbaPay"
let LOGGLY_API_URL = "https://logs-01.loggly.com/"

class Logger {

    static func log(
            message: String? = nil,
            url: String? = nil,
            method: String? = nil,
            responseCode: String? = nil,
            bodyParams: (any Codable)? = nil,
            response: Data? = nil
    ) {


        Task {
            if (!DataHolder.isProd || DataHolder.enabledLogsForProd) {
                print(TAG + " " + (message ?? ""))
            }

            if (DataHolder.isProd || DataHolder.enabledLogsForProd) {

//                    var jsonResponse: String? = nil
//                    var jsonBodyParams: String? = nil

//                    if response != nil {
//                        let decoder = JSONDecoder()
//                        let result = try! decoder.decode(Result.self, from: response!)
//
//                        jsonResponse = String(data: result.encoded, encoding: String.Encoding.utf8)
//                    }
                /*
                    if bodyParams != nil {
                        let jsonEncoder = JSONEncoder()
                        let jsonData = try jsonEncoder.encode(bodyParams!)
                        jsonResponse = String(data: jsonData, encoding: String.Encoding.utf8)
                    }*/

                let responseString = response != nil ? String(data: response!, encoding: String.Encoding.utf8) : nil

                let request = ApiLogEntry(
                        url: url,
                        method: method,
                        responseCode: responseCode,
//                        bodyParams: (jsonBodyParams?.contains("Card Holder") == true) ?
//                        "Содержимое скрыто для секьюрности, т.к. содержит данные карты" : jsonBodyParams,
                        response: responseString,
//                        response: jsonResponse,
                        messages: message
                )

                await logService(request: request)
            }
        }

    }
}
