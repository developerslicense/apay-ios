//
//  BLExternalApiApplePay.swift
//  AirbaPaySdk
//
//  Created by Mikhail Belikov on 15.05.2024.
//

import Foundation

extension AirbaPaySdk {

    func blProcessExternalApplePayNative() {
        let applePay = ApplePayManager(navigateCoordinator: navigateCoordinator)
        DataHolder.isApplePayFlow = true
        applePay.buyBtnTapped()
    }
    
    func blInitExternalApplePayWebView() {
        DataHolder.isApplePayFlow = true
        
        Task {
            blAuth(
                navigateCoordinator: navigateCoordinator,
                onSuccess: {
        //todo
                },
                paymentId: nil
            )
        }
    }
    
}
