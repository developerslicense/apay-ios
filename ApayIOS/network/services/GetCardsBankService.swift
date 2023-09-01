//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import Combine
import Alamofire

func getCardsBankService(
        pan: String,
        next: () -> Void
) async {

    do {
        let data = try await NetworkManager.shared.get(
                path: "api/v1/cards/info-by-pan/" + pan,
                parameters: nil
        )

        let result: CardsPanResponse = try Api.parseData(data: data)
        DataHolder.bankCode = result.bankCode
        next()

    } catch let error {
        print(error.localizedDescription)

    }
}