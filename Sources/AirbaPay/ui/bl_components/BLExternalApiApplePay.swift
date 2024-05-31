//
//  BLExternalApiApplePay.swift
//  AirbaPaySdk
//
//  Created by Mikhail Belikov on 29.05.2024.
//

import Foundation

func blProcessApplePay(
        applePayToken: String,
        navigateCoordinator: AirbaPayCoordinator
) {
    Task {
        if let result = await startPaymentWalletService(applePayToken: applePayToken) {
            DispatchQueue.main.async {

                if (result.errorCode != 0) {
                    let error = ErrorsCode(code: result.errorCode ?? 1).getError()
                    navigateCoordinator.openErrorPageWithCondition(errorCode: error.code)

                } else if (result.isSecure3D == true) {
                    navigateCoordinator.openAcquiring(redirectUrl: result.secure3D?.action)

                } else {
                    navigateCoordinator.openSuccess()

                }
            }

        } else {
            DispatchQueue.main.async {
                navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
            }
        }
    }

}
