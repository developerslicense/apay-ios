//
//  GetMerchantService.swift
//
//  Created by Mikhail Belikov on 02.02.2024.
//

import Foundation
import Combine
import Alamofire

func getMerchantInfoService() async -> MerchantsResponse? {
    do {
        let path = "api/v1/merchants"
        let data = try await NetworkManager.shared.get(
                path: path,
                parameters: nil
        )

        let result: MerchantsResponse = try Api.parseData(
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

