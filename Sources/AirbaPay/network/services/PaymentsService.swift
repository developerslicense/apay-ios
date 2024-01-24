//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import Combine
import Alamofire

func paymentDefaultService(
        params: PaymentDefaultRequest
) async -> PaymentEntryResponse? {

    do {
        let data = try await NetworkManager.shared.put(
                path: "api/v1/payments",
                parameters: params
        )

        let result: PaymentEntryResponse = try Api.parseData(data: data)
        return result

    } catch let error {
        print(error.localizedDescription)

        return nil
    }
}

func paymentSavedCardService(
        cardId: String,
        params: PaymentSavedCardRequest
) async -> PaymentEntryResponse? {

    do {
        let data = try await NetworkManager.shared.put(
                path: "api/v1/payments/" + cardId,
                parameters: params
        )

        let result: PaymentEntryResponse = try Api.parseData(data: data)
        return result

    } catch let error {
        print(error.localizedDescription)

        return nil
    }
}

func paymentGetCvv(
        cardId: String
) async -> GetCvvResponse? {

    do {
        let data = try await NetworkManager.shared.get(
                path: "api/v1/payments/cvv/" + cardId,
                parameters: nil
        )

        let result: GetCvvResponse = try Api.parseData(data: data)
        return result

    } catch let error {
        print(error.localizedDescription)

        return nil
    }
}


