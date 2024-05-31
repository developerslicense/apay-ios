//
//  BLCheckSavedCardNeedCvv.swift
//
//  Created by Mikhail Belikov on 06.05.2024.
//

import Foundation

func blCheckSavedCardNeedCvv(
        navigateCoordinator: AirbaPayCoordinator,
        selectedCard: BankCard,
        isLoading: @escaping (Bool) -> Void,
        onError: (() -> Void)? = nil,
        showCvv: @escaping () -> Void
) {
    Task {
        if let result = await paymentGetCvv(cardId: selectedCard.id!) {

            if (result.requestCvv == true) {
                showCvv()

            } else if (DataHolder.isRenderSecurityBiometry()) {
                blBiometricAuthenticate(
                        onSuccess: {
                            isLoading(true)
                            blProcessSavedCard(
                                    cardId: selectedCard.id ?? "",
                                    cvv: nil,
                                    isLoading: isLoading,
                                    navigateCoordinator: navigateCoordinator
                            )
                        },
                        onNotSecurity: {
                            showCvv()
                        }
                )

            } else if (DataHolder.isRenderSecurityCvv()) {// не объединять с 1-м, т.к. у этого приоритет ниже, чем у renderSecurityBiometry
                showCvv()

            } else {
                isLoading(true)
                blProcessSavedCard(
                        cardId: selectedCard.id ?? "",
                        cvv: nil,
                        isLoading: isLoading,
                        navigateCoordinator: navigateCoordinator
                )
            }

        } else if onError != nil {
            onError!()

        } else {
            DispatchQueue.main.async {
                isLoading(false)
                navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_5006.code)
            }
        }
    }
}
