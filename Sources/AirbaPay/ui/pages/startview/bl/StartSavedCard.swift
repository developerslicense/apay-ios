//
//  StartSavedCard.swift
//
//  Created by Mikhail Belikov on 18.01.2024.
//

import Foundation

func checkNeedCvv(
        cardId: String,
        isLoading: @escaping (Bool) -> Void,
        toggleCvv: @escaping () -> Void,
        navigateCoordinator: AirbaPayCoordinator
) {
    Task {
        if let result = await paymentGetCvv(cardId: cardId) {
            DataHolder.isApplePayFlow = false

            if (result.requestCvv! == true) {
                toggleCvv()

            } else {
                airbaPayBiometricAuthenticate(
                        onSuccess: {
                            startSavedCard(
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

func startSavedCard(
        cardId: String,
        cvv: String?,
        isLoading: @escaping (Bool) -> Void,
        navigateCoordinator: AirbaPayCoordinator
) {
    isLoading(true)

    Task {
        let params = PaymentSavedCardRequest(cvv: cvv ?? "")

        if let result = await paymentSavedCardService(
                cardId: cardId,
                params: params
        ) {
            DispatchQueue.main.async {
                isLoading(false)

                if result.status == "success"
                           || result.status == "auth" {
                    navigateCoordinator.openSuccess()


                } else if result.status == "secure3D" {
                    navigateCoordinator.openAcquiring(redirectUrl: result.secure3D?.action)

                } else {
                    navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_5006.code)
                }
            }
        } else {
            DispatchQueue.main.async {
                isLoading(false)
                navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_5006.code)
            }
        }
    }
}
