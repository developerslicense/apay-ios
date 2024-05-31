//
//  GetPaymentInfo.swift
//  AirbaPaySdk
//
//  Created by Mikhail Belikov on 29.05.2024.
//

import Foundation
import Combine
import Alamofire

func getPaymentService() async -> PaymentEntryResponse? {
    do {
        let path = "api/v1/payments"
        let data = try await NetworkManager.shared.get(
                path: path,
                parameters: nil
        )

        let result: PaymentEntryResponse = try Api.parseData(
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

