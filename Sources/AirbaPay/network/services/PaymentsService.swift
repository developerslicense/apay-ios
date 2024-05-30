//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import Combine
import Alamofire

func startPaymentDefaultService(
        params: PaymentDefaultRequest
) async -> PaymentEntryResponse? {

    do {
        let path = "api/v1/payments"
        let data = try await NetworkManager.shared.put(
                path: path,
                parameters: params
        )

        let result: PaymentEntryResponse = try Api.parseData(
                data: data,
                path: path,
                method: "PUT",
                bodyParams: params
        )

        return result

    } catch let error {
        print(error.localizedDescription)
        return nil
    }
}

func startPaymentSavedCardService(
        cardId: String,
        params: PaymentSavedCardRequest
) async -> PaymentEntryResponse? {

    do {
        let path = "api/v1/payments/" + cardId
        let data = try await NetworkManager.shared.put(
                path: path,
                parameters: params
        )

        let result: PaymentEntryResponse = try Api.parseData(
                data: data,
                path: path,
                method: "PUT",
                bodyParams: params
        )
        return result

    } catch let error {
        print(error.localizedDescription)
        return nil
    }
}

func startPaymentWalletService(
        applePayToken: String
) async -> PaymentEntryResponse? {

    DataHolder.isApplePayFlow = true

    let wallet = ApplePaymentWallet(token: applePayToken)
    let param = ApplePaymentWalletRequest(wallet: wallet)

    do {
        let path = "api/v1/payments/wallet"
        let data = try await NetworkManager.shared.put(
                path: path,
                parameters: param
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

func paymentGetCvv(
        cardId: String
) async -> GetCvvResponse? {

    do {
        let path = "api/v1/payments/cvv/" + cardId
        let data = try await NetworkManager.shared.get(
                path: path,
                parameters: nil
        )

        let result: GetCvvResponse = try Api.parseData(
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


