//
//  FetchData.swift
//
//  Created by Mikhail Belikov on 05.02.2024.
//

import Foundation

public class AirbaPay {
    static func fetchMerchantsWithNextStep(
            viewModel: StartProcessingViewModel,
            navigateCoordinator: AirbaPayCoordinator
    ) {
        Task {
            if let result = await getMerchantInfoService() {

                if (TestAirbaPayStates.shutDownTestFeatureSavedCards) {
                    DataHolder.featureSavedCards = false
                } else {
                    DataHolder.featureSavedCards = result.config?.renderSaveCards ?? false
                }

                if (TestAirbaPayStates.shutDownTestFeatureApplePay) {
                    DataHolder.featureApplePay = false
                } else {
                    DataHolder.featureApplePay = result.config?.renderApplePayButton ?? false
                }
            }

            initPaymentsWithNextStep(
                    viewModel: viewModel,
                    navigateCoordinator: navigateCoordinator
            )
        }
    }

    private static func initPaymentsWithNextStep(
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

    private static func fetchCards(
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
}
 
