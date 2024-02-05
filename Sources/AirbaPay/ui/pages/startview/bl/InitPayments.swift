//
//  InitPayments.swift
//
//  Created by Mikhail Belikov on 05.02.2024.
//

import Foundation

func initPayments(
        onApplePayResult:  @escaping (String?) -> Void,
        navigateCoordinator: AirbaPayCoordinator
) {
    Task {
        if let result = await createPaymentService() {
            if (DataHolder.featureApplePay) {
                authForApplePay(
                        paymentCreateResponse: result,
                        navigateCoordinator: navigateCoordinator,
                        onApplePayResult: onApplePayResult
                )

            } else {
                onApplePayResult(nil)
            }

        } else {
            navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
        }
    }
}


private func authForApplePay(
        paymentCreateResponse: PaymentCreateResponse,
        navigateCoordinator: AirbaPayCoordinator,
        onApplePayResult: (String?) -> Void
) {
    Task {
        let params = AuthRequest(

        )

        if let result = await authService(params: params) {
            loadApplePayButton(
                    onApplePayResult: { url in

                    }
            )
        } else {
            navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
        }
    }
}

private func loadApplePayButton(
        onApplePayResult: @escaping (String?) -> Void
) {
    Task {
        if let result = await getApplePayService() {
            onApplePayResult(result.buttonUrl)
        } else {
            onApplePayResult(nil)
        }
    }
}

