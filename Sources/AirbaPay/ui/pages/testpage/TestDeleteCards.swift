//
//  TestDeleteCards.swift
//
//  Created by Mikhail Belikov on 07.02.2024.
//

import Foundation

public func testDelCards(
        accountId: String
) {

    blAuth(
            navigateCoordinator: nil,
            onSuccess: {
                Task {
                    if let cards = await getCardsService(accountId: accountId) {
                        var index = 0

                        while index < cards.count {
                            await deleteCardsService(cardId: cards[index].id ?? "")
                            index = index + 1
                        }
                    }
                }
            },
            paymentId: nil
    )
}
