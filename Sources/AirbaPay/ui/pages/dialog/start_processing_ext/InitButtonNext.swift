//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import SwiftUI

struct InitViewStartProcessingButtonNext: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    var savedCards: Array<BankCard>
    var actionClose: () -> Void
    var isAuthenticated: Bool
    var selectedCard: BankCard?
    var needTopPadding: Bool = true

    var body: some View {
        if (!savedCards.isEmpty
                && isAuthenticated
           ) {
            ViewButton(
                    title: payAmount() + " " + DataHolder.purchaseAmountFormatted,
                    actionClick: {
                        actionClose()
                        navigateCoordinator.openHome(
                                cardId: selectedCard?.id,
                                maskedPan: selectedCard?.maskedPan,
                                dateExpired: selectedCard?.getExpiredCleared()
                        )
                    }
            )
                    .padding(.horizontal, 16)
                    .padding(.top, needTopPadding ? 16 : 0)
                    .padding(.bottom, 32)

        } else {
            ViewButton(
                    title: paymentByCard2(),
                    actionClick: {
                        actionClose()
                        navigateCoordinator.openHome()
                    }
            )
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 32)
        }
    }
}
