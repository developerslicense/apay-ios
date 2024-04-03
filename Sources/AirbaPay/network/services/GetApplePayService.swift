//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import Combine
import Alamofire

func getApplePayService() async -> ApplePayButtonResponse? {
    do {
        let path = "api/v1/wallets/apple-pay/button"
        let data = try await NetworkManager.shared.get(
                path: path,
                parameters: nil
        )

        let result: ApplePayButtonResponse = try Api.parseData(
                data: data,
                path: path,
                method: "GET"
        )
        return result

    } catch let error {
        print(error.localizedDescription)
        return nil
    }
}
