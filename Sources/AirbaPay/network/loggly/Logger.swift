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
            bodyParams: (any Encodable)? = nil,
            response: Data? = nil
    ) {


        Task {
            if (!DataHolder.isProd || DataHolder.enabledLogsForProd) {
                print(TAG + " " + (message ?? ""))
            }

            if (DataHolder.isProd || DataHolder.enabledLogsForProd) {

                var jsonBodyParams: String? = nil

                if bodyParams != nil {
                    jsonBodyParams = try String(bodyParams!.toJSON())
                }

                let responseString = response != nil ? String(data: response!, encoding: String.Encoding.utf8) : nil

                let request = ApiLogEntry(
                        url: (url?.contains("api/v1/cards/info-by-pan") == true) ? "api/v1/cards/info-by-pan/_pan_number_hiden" : url,
                        method: method,
                        responseCode: responseCode,
                        bodyParams: (jsonBodyParams?.contains("Card Holder") == true || jsonBodyParams?.contains("password") == true) ?
                                "Содержимое скрыто для секьюрности" : jsonBodyParams,
                        response: responseString,
                        messages: message
                )

                await logService(request: request)
            }
        }

    }
}

extension Encodable {
    /// Converting object to postable JSON
    func toJSON(_ encoder: JSONEncoder = JSONEncoder()) throws -> NSString {
        let data = try encoder.encode(self)
        let result = String(decoding: data, as: UTF8.self)
        return NSString(string: result)
    }
}
