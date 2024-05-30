//
//  BLProcessSavedCard.swift
//
//  Created by Mikhail Belikov on 18.01.2024.
//

import Foundation

func blProcessSavedCard(
        cardId: String,
        cvv: String?,
        isLoading: @escaping (Bool) -> Void,
        navigateCoordinator: AirbaPayCoordinator
) {

    Task {
        let params = PaymentSavedCardRequest(cvv: cvv ?? "")

        if let result = await startPaymentSavedCardService(
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
