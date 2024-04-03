//
//  LogglyService.swift
//
//  Created by Mikhail Belikov on 28.03.2024.
//

import Foundation
import Combine
import Alamofire

func logService(
        request: ApiLogEntry
) async {

    do {
        let data = try await NetworkManager.shared.postLoggly(
                path: "inputs/ca7c5dd2-a192-4c8e-b4e5-ad9836453a38/tag/ios",
                parameters: LogglyRequest(request: request)
        )

        let result: LogglyResponse = try Api.parseDataLoggly(data: data)

    } catch let error {
        print("AirbaPayLoggly postLoggly error")
        print(error.localizedDescription)
    }
}
