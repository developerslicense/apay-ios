//
//  ApplePayViewModel.swift
//
//  Created by Mikhail Belikov on 05.04.2024.
//

import Foundation

public class ApplePayViewModel {

    public func auth(
            onError: @escaping () -> Void,
            onSuccess: @escaping () -> Void
    ) {
        let params = AuthRequest(
                password: DataHolder.password,
                paymentId: nil,
                terminalId: DataHolder.terminalId,
                user: DataHolder.shopId
        )

        Task {
            if let resultAuth = await authService(params: params) {
                DataHolder.accessToken = resultAuth.accessToken

                if let resultCreatePayment = await createPaymentService() {
                    let params = AuthRequest(
                            password: DataHolder.password,
                            paymentId: resultCreatePayment.id,
                            terminalId: DataHolder.terminalId,
                            user: DataHolder.shopId
                    )

                    if let result = await authService(params: params) {
                        onSuccess()
                    } else {
                        onError()
                    }

                } else {
                    onError()
                }
            } else {
                onError()
            }
        }
    }

    public func processingWallet(
            navigateCoordinator: AirbaPayCoordinator,
            applePayToken: String
    ) {

        Task {
            if let result = await putPaymentWallet(applePayToken: applePayToken) {
                if result.errorCode != 0 {
                    let error = ErrorsCode(code: result.errorCode ?? 1).getError()
                    DataHolder.externalApplePayRedirect = (nil, false)
                    redirectTo(
                            defaultRedirectAction: {
                                navigateCoordinator.openErrorPageWithCondition(errorCode: error.code)
                            }
                    )

                } else if result.isSecure3D == true {
                    let url = result.secure3D?.action
                    DataHolder.externalApplePayRedirect = (url, false)
                    redirectTo(
                            defaultRedirectAction: {
                                navigateCoordinator.openAcquiring(redirectUrl: url)
                            }
                    )

                } else {
                    DataHolder.externalApplePayRedirect = (nil, true)
                    redirectTo(
                            defaultRedirectAction: {
                                navigateCoordinator.openSuccess()
                            }
                    )
                }

            } else {
                DataHolder.externalApplePayRedirect = (nil, false)
                redirectTo(
                        defaultRedirectAction: {
                            navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
                        }
                )
            }
        }
    }

    func redirectTo(
            defaultRedirectAction: () -> Void
    ) {
        if DataHolder.redirectFromStoryboardToSwiftUi != nil {
            DataHolder.redirectFromStoryboardToSwiftUi!()
        } else {
            defaultRedirectAction()
        }
    }
}
