//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import Combine
import Alamofire

func getApplePayService() async -> ApplePayButtonResponse? {
    do {
        let data = try await NetworkManager.shared.get(
                path: "api/v1/wallets/apple-pay/button",
                parameters: nil
        )

        let result: ApplePayButtonResponse = try Api.parseData(data: data)
        return result

    } catch let error {
        print(error.localizedDescription)
        return nil
    }
}
