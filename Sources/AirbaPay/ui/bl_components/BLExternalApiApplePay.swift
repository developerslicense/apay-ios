//
//  ExternalApiApplePay.swift
//  AirbaPaySdk
//
//  Created by Mikhail Belikov on 15.05.2024.
//

import Foundation

extension AirbaPaySdk {

    func blProcessExternalApplePayNative() {
        blAuth(
                navigateCoordinator: navigateCoordinator,
                onSuccess: {
                    blInitPayments(
                            onApplePayResult: { _ in
                                let applePay = ApplePayManager(navigateCoordinator: self.navigateCoordinator)
                                DataHolder.isApplePayFlow = true
                                applePay.buyBtnTapped()
                            },
                            navigateCoordinator: self.navigateCoordinator
                    )
                },
                paymentId: nil
        )
    }

    func blInitExternalApplePayWebView() {
        DataHolder.isApplePayFlow = true

        Task {
            blAuth(
                    navigateCoordinator: navigateCoordinator,
                    onSuccess: {
                        blInitPayments(
                                onApplePayResult: { url in

                                },
                                navigateCoordinator: self.navigateCoordinator
                        )
                    },
                    paymentId: nil
            )
        }
    }
}
