//
//  ExternalApiApplePay.swift
//  AirbaPaySdk
//
//  Created by Mikhail Belikov on 15.05.2024.
//

import Foundation

extension AirbaPaySdk {

    func processExternalApplePayNativeImpl() {
        let applePay = ApplePayManager(navigateCoordinator: navigateCoordinator)
        DataHolder.isApplePayFlow = true
        applePay.buyBtnTapped()
    }
    
    func initExternalApplePayWebViewImpl() {
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
