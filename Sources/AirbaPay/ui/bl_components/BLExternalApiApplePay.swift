//
//  ExternalApiApplePay.swift
//  AirbaPaySdk
//
//  Created by Mikhail Belikov on 15.05.2024.
//

import Foundation

extension AirbaPaySdk {

    func blProcessExternalApplePay() {
        blAuth(
                navigateCoordinator: navigateCoordinator,
                onSuccess: {
                    blInitPayments(
                            onApplePayResult: { _ in
                                DispatchQueue.main.async {
                                    DataHolder.isApplePayFlow = true
                                    self.navigateCoordinator.applePay!.buyBtnTapped()
                                }
                            },
                            navigateCoordinator: self.navigateCoordinator
                    )
                },
                paymentId: nil
        )
    }
}
