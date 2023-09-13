//
// Created by Mikhail Belikov on 01.09.2023.
//

import Foundation
import SwiftUI

func startPaymentProcessing(
        isLoading: @escaping (Bool) -> Void,
        cardId: String,
        navigateCoordinator: AirbaPayCoordinator
) {
    Task {
        await startCreatePayment(
                cardId: cardId,
                isLoading: isLoading,
                on3DS: { redirectUrl in
                    isLoading(false)
                    navigateCoordinator.openWebView(redirectUrl: redirectUrl)
                },
                onSuccess: {
                    isLoading(false)
                    navigateCoordinator.openSuccess()
                },
                onError: { errorCode in
                    isLoading(false)
                    navigateCoordinator.openErrorPageWithCondition(errorCode: errorCode.code)
                }
        )
    }
}

func startCreatePayment(
        cardId: String,
        isLoading: @escaping (Bool) -> Void,
        on3DS: @escaping (String?) -> Void,
        onSuccess: @escaping () -> Void,
        onError: @escaping (ErrorsCodeBase) -> Void
) async {
    if let result = await createPaymentService(cardId: cardId) {
        if result.status == "new" {
            DispatchQueue.main.async { isLoading(false) }

        } else if result.status == "success"
                          || result.status == "auth" {
            DispatchQueue.main.async { onSuccess() }

        } else if result.status == "secure3D" {
            DispatchQueue.main.async { on3DS(result.redirectURL) }

        } else {
            DispatchQueue.main.async { onError(ErrorsCode().error_1) }
        }

    } else {
        DispatchQueue.main.async { onError(ErrorsCode().error_1) }
    }
}
