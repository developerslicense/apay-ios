//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import Combine
import Alamofire

func paymentAccountEntryRetryService() async -> PaymentEntryResponse? {

    do {
        let data = try await NetworkManager.shared.put(
                path: "api/v1/payments/retry",
                parameters: nil
        )

        let result: PaymentEntryResponse = try Api.parseData(data: data)
        return result

    } catch let error {
        print(error.localizedDescription)

        return nil
    }
}