//
//  ApplePayViewModel.swift
//
//  Created by Mikhail Belikov on 05.04.2024.
//

import Foundation

public class ApplePayViewModel: ObservableObject {

    @MainActor @Published public var appleUrlResult: String? = nil

    public init() {}

    func processingWallet(
            navigateCoordinator: AirbaPayCoordinator,
            applePayToken: String
    ) {

        Task {
            if let result = await putPaymentWallet(applePayToken: applePayToken) {
                if result.errorCode != 0 {
                    let error = ErrorsCode(code: result.errorCode ?? 1).getError()
                    DispatchQueue.main.async {
                        navigateCoordinator.openErrorPageWithCondition(errorCode: error.code)
                    }

                } else if result.isSecure3D == true {
                    let url = result.secure3D?.action
                    DispatchQueue.main.async {
                        navigateCoordinator.openAcquiring(redirectUrl: url)
                    }

                } else {
                    DispatchQueue.main.async {
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
}
