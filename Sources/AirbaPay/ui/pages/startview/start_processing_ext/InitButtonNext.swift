//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import SwiftUI

struct InitViewStartProcessingButtonNext: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    @StateObject var viewModel = StartProcessingViewModel()
    var toggleCvv: () -> Void
    var isLoading: (Bool) -> Void
    var needTopPadding: Bool = true

    var body: some View {
        ViewButton(
                title: payAmount() + " " + DataHolder.purchaseAmountFormatted,
                actionClick: {
                    blCheckSavedCardNeedCvv(
                            cardId: viewModel.selectedCard?.id ?? "",
                            toggleCvv: toggleCvv,
                            isLoading: isLoading,
                            navigateCoordinator: navigateCoordinator
                    )
                }
        )
                .padding(.horizontal, 16)
                .padding(.top, needTopPadding ? 16 : 0)
                .padding(.bottom, 32)


    }
}
