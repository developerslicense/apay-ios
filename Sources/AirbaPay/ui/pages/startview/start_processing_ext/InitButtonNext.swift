//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import SwiftUI

struct InitViewStartProcessingButtonNext: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    var savedCards: Array<BankCard>
    var showCvv: () -> Void
    var isLoading: (Bool) -> Void
    var selectedCard: BankCard?
    var isAuthenticated: Bool = true
    var needTopPadding: Bool = true

    var body: some View {
        if (!savedCards.isEmpty
                && isAuthenticated
           ) {
            ViewButton(
                    title: payAmount() + " " + DataHolder.purchaseAmountFormatted,
                    actionClick: {
                        startSavedCard(
                                cardId: selectedCard?.id ?? "",
                                cvv: selectedCard?.cvv ?? "",
                                isLoading: isLoading,
                                showCvv: showCvv,
                                navigateCoordinator: navigateCoordinator
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
                        navigateCoordinator.openHome()
                    }
            )
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 32)
        }
    }
}
