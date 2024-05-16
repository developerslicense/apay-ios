//
//  ExternalPaySavedCard.swift
//
//  Created by Mikhail Belikov on 06.05.2024.
//

import Foundation

extension AirbaPaySdk {

    func externalPaySavedCardImpl(
            cardId: String,
            isLoading: @escaping (Bool) -> Void
    ) {
        DataHolder.isApplePayFlow = false

        blAuth(
                navigateCoordinator: navigateCoordinator,
                onSuccess: {
                    blCheckSavedCardNeedCvv(
                            cardId: cardId,
                            toggleCvv: {},
                            isLoading: isLoading,
                            navigateCoordinator: self.navigateCoordinator
                    ),
                    paymentId: nil
                }
        )
    }
}
