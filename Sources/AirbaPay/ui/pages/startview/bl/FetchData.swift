//
//  FetchData.swift
//
//  Created by Mikhail Belikov on 05.02.2024.
//

import Foundation

func fetchMerchantsWithNextStep(
        viewModel: StartProcessingViewModel,
        navigateCoordinator: AirbaPayCoordinator
) {
    Task {
        if let result = await getMerchantInfoService() {
            DataHolder.featureSavedCards = result.configuration?.renderSaveCards ?? false
            DataHolder.featureApplePay = result.configuration?.renderApplePayButton ?? false

        }

        initPaymentsWithNextStep(
                viewModel: viewModel,
                navigateCoordinator: navigateCoordinator
        )
    }
}

private func initPaymentsWithNextStep(
        viewModel: StartProcessingViewModel,
        navigateCoordinator: AirbaPayCoordinator
) {
    initPayments(
            onApplePayResult: { url in
                DataHolder.applePayButtonUrl = url

                Task {
                    if (url != nil) {
                        await MainActor.run {
                            viewModel.applePayUrl = url
                        }
                    }
                }

                if (DataHolder.featureSavedCards) {
                    fetchCards(
                            viewModel: viewModel,
                            navigateCoordinator: navigateCoordinator
                    )

                } else {
                    Task {
                        await MainActor.run {
                            viewModel.isLoading = false
                            navigateCoordinator.openHome()
                        }
                    }
                }

            },
            navigateCoordinator: navigateCoordinator
    )
}

private func fetchCards(
        viewModel: StartProcessingViewModel,
        navigateCoordinator: AirbaPayCoordinator
) {
    Task {
        if let result = await getCardsService(accountId: DataHolder.accountId) {
            await MainActor.run {
                viewModel.savedCards = result
                DataHolder.hasSavedCards = !result.isEmpty
                viewModel.isLoading = false

                if result.isEmpty {
                    navigateCoordinator.openHome()
                } else {
                    viewModel.selectedCard = result[0]
                }
            }

        } else {
            await MainActor.run {
                viewModel.isLoading = false
                navigateCoordinator.openHome()
            }
        }
    }

}
 
