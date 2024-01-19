//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import SwiftUI

func startCreatePayment(
        onSuccess: @escaping (ApplePayButtonResponse?) -> Void,
        onError: @escaping (ErrorsCodeBase) -> Void
) async {
    if let result: PaymentCreateResponse = await createPaymentService() {
        let authParams = AuthRequest(
                password: DataHolder.password,
                paymentId: result.id,
                terminalId: DataHolder.terminalId,
                user: DataHolder.shopId
        )

        if let res = await authService(params: authParams) {
            await MainActor.run {
                DataHolder.accessToken = res.accessToken
            }

            await onSuccessAuth(
                    onError: onError,
                    onSuccess: onSuccess
            )

        } else {
            onError(ErrorsCode().error_1)
        }

    } else {
        onError(ErrorsCode().error_1)
    }
}

private func onSuccessAuth(
        onError: @escaping (ErrorsCodeBase) -> Void,
        onSuccess: @escaping (ApplePayButtonResponse?) -> Void
) async {
    if let result = await getApplePayService() {
        DispatchQueue.main.async { onSuccess(result) }

    } else {
        onError(ErrorsCode().error_1)
    }
}


