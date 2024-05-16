//
//  BLAuth.swift
//
//  Created by Mikhail Belikov on 06.05.2024.
//

import Foundation

func blAuth(
        navigateCoordinator: AirbaPayCoordinator?,
        onSuccess: @escaping () -> Void,
        paymentId: String?
) {
    Task {
        let authParams = AuthRequest(
                password: DataHolder.password,
                paymentId: paymentId,
                terminalId: DataHolder.terminalId,
                user: DataHolder.shopId
        )

        if let res = await authService(params: authParams) {
            DataHolder.accessToken = res.accessToken
            onSuccess()

        } else {
            DispatchQueue.main.async {
                navigateCoordinator?.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
            }
        }
    }
}
