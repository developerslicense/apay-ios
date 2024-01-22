//
//  StartSavedCard.swift
//
//  Created by Mikhail Belikov on 18.01.2024.
//

import Foundation

func startSavedCard(
        cardId: String,
        cvv: String,
        isLoading: @escaping (Bool) -> Void,
        showCvv: @escaping () -> Void,
        navigateCoordinator: AirbaPayCoordinator
) {
    isLoading(true)

    Task {
        let params = PaymentSavedCardRequest(cvv: cvv)

        if let result = await paymentSavedCardService(
                cardId: cardId,
                params: params
        ) {
            DispatchQueue.main.async {
                isLoading(false)

                if result.status == "new" {
                    showCvv()

                } else if result.status == "success"
                                  || result.status == "auth" {
                    navigateCoordinator.openSuccess()


                } else if result.status == "secure3D" {
                    navigateCoordinator.openAcquiring(redirectUrl: result.secure3D?.action)

                } else {
                    navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_5006.code)
                }
            }
        } else {
            DispatchQueue.main.async { navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code) }
        }
    }
}
