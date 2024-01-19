//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import SwiftUI

struct InitViewStartProcessingButtonNext: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    @StateObject var viewModel = StartProcessingViewModel()
    var showCvv: () -> Void
    var isLoading: (Bool) -> Void
    var isAuthenticated: Bool = true
    var needTopPadding: Bool = true

    var body: some View {
        if (!viewModel.savedCards.isEmpty
                && isAuthenticated
           ) {
            ViewButton(
                    title: payAmount() + " " + DataHolder.purchaseAmountFormatted,
                    actionClick: {
                        startSavedCard(
                                cardId: viewModel.selectedCard?.id ?? "",
                                cvv: viewModel.selectedCard?.cvv ?? "",
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
