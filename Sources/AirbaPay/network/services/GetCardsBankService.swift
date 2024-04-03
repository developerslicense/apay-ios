//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import Combine
import Alamofire

func getCardsBankService(
        pan: String,
        next: () -> Void,
        isLoading: @escaping (Bool) -> Void
) async {
    let path = "api/v1/cards/info-by-pan/" + pan

    do {
        let data = try await NetworkManager.shared.get(
                path: path,
                parameters: nil
        )

        let result: CardsPanResponse = try Api.parseData(
                data: data,
                path: path,
                method: "GET"
        )

        DataHolder.bankCode = result.bankCode
        next()

    } catch let error {

        print(error.localizedDescription)
        isLoading(false)
    }
}
