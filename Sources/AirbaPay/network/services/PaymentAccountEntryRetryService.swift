//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import Combine
import Alamofire

func paymentAccountEntryRetryService() async -> PaymentEntryResponse? {

    do {
        let path = "api/v1/payments/retry"
        let data = try await NetworkManager.shared.put(
                path: path,
                parameters: nil
        )

        let result: PaymentEntryResponse = try Api.parseData(
                data: data,
                path: path,
                method: "PUT"
        )

        return result

    } catch let error {
        print(error.localizedDescription)
        return nil
    }
}
