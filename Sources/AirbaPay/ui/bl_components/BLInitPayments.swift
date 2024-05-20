//
//  InitPayments.swift
//
//  Created by Mikhail Belikov on 05.02.2024.
//

import Foundation

func blInitPayments(
        onApplePayResult: @escaping (String?) -> Void,
        onError: (() -> Void)? = nil,
        navigateCoordinator: AirbaPayCoordinator
) {
    Task {
        if let result = await createPaymentService() {
            blAuth(
                    navigateCoordinator: navigateCoordinator,
                    onSuccess: {
                        if (DataHolder.featureApplePay) {
                            if (DataHolder.isApplePayNative) {
                                onApplePayResult(nil)

                            } else {
                                loadApplePayButton(onApplePayResult: onApplePayResult)
                            }

                        } else {
                            onApplePayResult(nil)
                        }
                    },
                    paymentId: result.id
            )

        } else {
            DispatchQueue.main.async {
                onError != nil ? onError!() : navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
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

extension AirbaPaySdk {

    func blInitExternalPayments(
            onSuccess: @escaping () -> Void,
            onError: @escaping () -> Void
    ) {
        DataHolder.isApplePayFlow = false

        blInitPayments(
                onApplePayResult: { _ in
                    onSuccess()
                },
                onError: onError,
                navigateCoordinator: self.navigateCoordinator
        )
    }
}
