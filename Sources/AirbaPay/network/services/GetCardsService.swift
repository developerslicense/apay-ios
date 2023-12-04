//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import Combine
import Alamofire

func getCardsService(accountId: String) async -> [BankCard]? {
    do {
        let data = try await NetworkManager.shared.get(
                path: "api/v1/cards/" + accountId,
                parameters: nil
        )

        let result: [BankCard] = try Api.parseData(data: data)

        let newResult = result.map { card in
            var icon = ""

            switch (card.type) {
            case "VISA": icon = CardType.VISA
            case "MC": icon = CardType.MASTER_CARD
            case "AE": icon = CardType.AMERICAN_EXPRESS
            default: icon = CardType.INVALID
            }

            var card1 = card
            card1.typeIcon = icon

            return card1
        }

        return newResult

    } catch let error {
        print(error.localizedDescription)
        return nil
    }
}