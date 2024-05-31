//
//  BLAuth.swift
//
//  Created by Mikhail Belikov on 06.05.2024.
//

import Foundation

func blAuth(
        navigateCoordinator: AirbaPayCoordinator?,
        password: String? = nil,
        terminalId: String? = nil,
        shopId: String? = nil,
        onSuccess: @escaping (String) -> Void,
        onError: (() -> Void)? = nil,
        paymentId: String?

) {
    Task {
        let authParams = AuthRequest(
                password: password,
                paymentId: paymentId,
                terminalId: terminalId,
                user: shopId
        )

        if let res = await authService(params: authParams) {
            onSuccess(res.accessToken ?? "")

        } else {
            DispatchQueue.main.async {
                onError != nil ? onError!() : navigateCoordinator?.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
            }
        }
    }
}

func blUpdateToken(
        navigateCoordinator: AirbaPayCoordinator?,
        paymentId: String,
        onSuccess: @escaping (String) -> Void,
        onError: (() -> Void)? = nil
) {
    Task {
        if let res = await updateAuth(paymentId: paymentId) {
            onSuccess(paymentId)

        } else {
            DispatchQueue.main.async {
                onError != nil ? onError!() : navigateCoordinator?.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
            }
        }
    }
}
