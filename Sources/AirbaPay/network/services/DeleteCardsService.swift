//
// Created by Mikhail Belikov on 7.02.2024.
//

import Foundation
import Combine
import Alamofire

func deleteCardsService(cardId: String) async -> Bool {
    do {
        let data = try await NetworkManager.shared.delete(
                path: "api/v1/cards/" + cardId,
                parameters: nil
        )

        return true
    } catch let error {
        print(error.localizedDescription)
        return false
    }
}
