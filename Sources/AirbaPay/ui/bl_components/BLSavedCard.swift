//
//  ExternalPaySavedCard.swift
//
//  Created by Mikhail Belikov on 06.05.2024.
//

import Foundation

extension AirbaPaySdk {

    func blPaySavedCard(
            cardId: String,
            isLoading: @escaping (Bool) -> Void
    ) {
        DataHolder.isApplePayFlow = false

        blAuth(
                navigateCoordinator: navigateCoordinator,
                onSuccess: {
                    blCheckSavedCardNeedCvv(
                            cardId: cardId,
                            toggleCvv: { },
                            isLoading: isLoading,
                            navigateCoordinator: self.navigateCoordinator
                    )

                },
                paymentId: nil
        )
    }
}

func blGetCards(
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
