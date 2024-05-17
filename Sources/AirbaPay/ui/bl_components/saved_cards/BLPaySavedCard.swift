//
//  ExternalPaySavedCard.swift
//
//  Created by Mikhail Belikov on 06.05.2024.
//

import Foundation
import BottomSheet
import UIKit
import SwiftUI

extension AirbaPaySdk {

    func blPaySavedCard(
            card: BankCard,
            isLoading: @escaping (Bool) -> Void,
            onError: @escaping () -> Void,
            needFaceId: Bool = true,
            airbaPaySdk: AirbaPaySdk
    ) {
        DataHolder.isApplePayFlow = false

        blAuth(
                navigateCoordinator: navigateCoordinator,
                onSuccess: {
                    blInitPayments(
                            onApplePayResult: { _ in
                                blCheckSavedCardNeedCvv(
                                        cardId: card.id ?? "",
                                        needFaceId: needFaceId,
                                        toggleCvv: {
                                            showBottomSheetEnterCvv(
                                                    airbaPaySdk: airbaPaySdk,
                                                    selectedCard: card
                                            )
                                        },
                                        isLoading: isLoading,
                                        navigateCoordinator: self.navigateCoordinator
                                )
                            },
                            onError: onError,
                            navigateCoordinator: self.navigateCoordinator
                    )
                },
                paymentId: nil
        )

    }
}

