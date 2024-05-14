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
            authWithPaymentIdAndForApplePay(
                    paymentCreateResponse: result,
                    navigateCoordinator: navigateCoordinator,
                    onApplePayResult: onApplePayResult
            )

        } else {
            DispatchQueue.main.async {
                navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
            }
        }
    }
}


private func authWithPaymentIdAndForApplePay(
        paymentCreateResponse: PaymentCreateResponse,
        navigateCoordinator: AirbaPayCoordinator,
        onApplePayResult: @escaping (String?) -> Void
) {
    Task {
        let params = AuthRequest(
                password: DataHolder.password,
                paymentId: paymentCreateResponse.id,
                terminalId: DataHolder.terminalId,
                user: DataHolder.shopId
        )

        if let result = await authService(params: params) {
            if (DataHolder.featureApplePay) {
                loadApplePayButton(onApplePayResult: onApplePayResult)

            } else {
                onApplePayResult(nil)
            }

        } else {
            DispatchQueue.main.async {
                navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
            }
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

