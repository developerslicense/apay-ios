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
            bodyParams: String? = nil,
            response: String? = nil
    ) {
        
        
            Task {
                if (!DataHolder.isProd || DataHolder.enabledLogsForProd) {
                    print(TAG + " " + (message ?? ""))
                }

                if (DataHolder.isProd || DataHolder.enabledLogsForProd) {

                    let request = ApiLogEntry(
                        url: url,
                        method: method,
                        responseCode: responseCode,
                        bodyParams: (bodyParams?.contains("Card Holder") == true) ?
                        "Содержимое скрыто для секьюрности, т.к. содержит данные карты" : bodyParams,
                        response: response,
                        messages: message
                    )

                    await logService(request: request)
                }
            }

    }
}
