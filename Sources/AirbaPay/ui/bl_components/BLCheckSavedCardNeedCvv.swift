//
//  BLCheckSavedCardNeedCvv.swift
//
//  Created by Mikhail Belikov on 06.05.2024.
//

import Foundation

func blCheckSavedCardNeedCvv(
        cardId: String,
        toggleCvv: @escaping () -> Void,
        isLoading: @escaping (Bool) -> Void,
        navigateCoordinator: AirbaPayCoordinator
) {
    Task {
        if let result = await paymentGetCvv(cardId: cardId) {
            DataHolder.isApplePayFlow = false

            if (result.requestCvv! == true) {
                toggleCvv()

            } else {
                blBiometricAuthenticate(
                        onSuccess: {
                            blProcessSavedCard(
                                    cardId: cardId,
                                    cvv: nil,
                                    isLoading: isLoading,
                                    navigateCoordinator: navigateCoordinator
                            )
                        },
                        onNotSecurity: {
                            toggleCvv()
                        }
                )
            }

        } else {
            DispatchQueue.main.async {
                isLoading(false)
                navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_5006.code)
            }
        }
    }
}
