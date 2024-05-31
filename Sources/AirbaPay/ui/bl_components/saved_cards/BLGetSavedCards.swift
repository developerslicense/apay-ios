//
//  BLGetSavedCards.swift
//  AirbaPaySdk
//
//  Created by Mikhail Belikov on 17.05.2024.
//

import Foundation

func blGetSavedCards(
        onSuccess: @escaping ([BankCard]) -> Void,
        onNoCards: @escaping () -> Void
) {
    Task {
        if let result = await getCardsService(accountId: DataHolder.accountId) {
            await MainActor.run {
                DataHolder.hasSavedCards = !result.isEmpty
                result.isEmpty ? onNoCards() : onSuccess(result)
            }

        } else {
            onNoCards()
        }
    }
}
