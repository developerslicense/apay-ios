//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import SwiftUI

struct InitViewStartProcessingButtonNext: View {
    var navigateCoordinator: AirbaPayCoordinator
    @StateObject var viewModel = StartProcessingViewModel()
    var showCvv: () -> Void
    var isLoading: (Bool) -> Void
    var needTopPadding: Bool = true

    var body: some View {
        ViewButton(
                title: payAmount() + " " + DataHolder.purchaseAmountFormatted,
                actionClick: {
                    if viewModel.selectedCard != nil {
                        blCheckSavedCardNeedCvv(
                                navigateCoordinator: navigateCoordinator,
                                selectedCard: viewModel.selectedCard!,
                                isLoading: isLoading,
                                onError: nil,
                                showCvv: showCvv
                        )
                    } else {
                        print("AirbaPay. Ошибка. Нет выбранной карты")
                    }
                }
        )
                .padding(.horizontal, 16)
                .padding(.top, needTopPadding ? 16 : 0)
                .padding(.bottom, 32)


    }
}
