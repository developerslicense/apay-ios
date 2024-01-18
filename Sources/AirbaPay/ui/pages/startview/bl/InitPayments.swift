//
//  InitPayment.swift
//  ios-pay_compleated-2
//
//  Created by Mikhail Belikov on 18.01.2024.
//

import Foundation

func initPayments(
        onApplePayLoadSuccess: (String?) -> Void,
        navigateCoordinator: AirbaPayCoordinator

//    isLoading : MutableState<Boolean>,
//    onGooglePayLoadSuccess: (String?) -> Unit
) async {
    if let result: PaymentCreateResponse = await createPaymentService() {
        await authForGooglePay(
                paymentId: result.id,
                onApplePayLoadSuccess: onApplePayLoadSuccess,
                navigateCoordinator: navigateCoordinator
        )

    } else {
        navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
    }
}

private func authForGooglePay(
        paymentId: String?,
        onApplePayLoadSuccess: (String?) -> Void,
        navigateCoordinator: AirbaPayCoordinator
) async {
    let authParams = AuthRequest(
            password: DataHolder.password,
            paymentId: paymentId,
            terminalId: DataHolder.terminalId,
            user: DataHolder.shopId
    )

    if let result = await authService(params: authParams) {
        await MainActor.run {
            DataHolder.accessToken = result.accessToken
        }

        await loadAppleButton(
                onApplePayLoadSuccess: onApplePayLoadSuccess,
                navigateCoordinator: navigateCoordinator
        )

    } else {
        DispatchQueue.main.async { navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code) }
    }
}

private func loadAppleButton(
        onApplePayLoadSuccess: (String?) -> Void,
        navigateCoordinator: AirbaPayCoordinator
) async {
    if let result: ApplePayButtonResponse = await getApplePayService() {
        onApplePayLoadSuccess(result.buttonUrl)

    } else {
        navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
    }
}