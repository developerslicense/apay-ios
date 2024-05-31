//
//  DeleteCard.swift
//  AirbaPaySdk
//
//  Created by Mikhail Belikov on 17.05.2024.
//

import Foundation

extension AirbaPaySdk {

    func blDeleteCard(
            cardId: String,
            onSuccess: @escaping () -> Void,
            onError: @escaping () -> Void
    ) {
        Task {
            let result = await deleteCardsService(cardId: cardId)
            result ? onSuccess() : onError()
        }
    }
}
