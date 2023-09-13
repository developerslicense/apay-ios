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


    var body: some View {
        if (!savedCards.isEmpty
                && isAuthenticated
           ) {
            ViewButton(
                    title: payAmount() + " " + DataHolder.purchaseAmountFormatted,
                    actionClick: {
                        actionClose()
                        navigateCoordinator.openHome(cardId: selectedCard?.id)
                    }
            )
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
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
                    .padding(.top, 16)
                    .padding(.bottom, 32)
        }
    }
}
