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
        blGetPaymentInfo(
                onSuccess: { r in
                    DataHolder.purchaseNumber = r.orderNumber ?? r.invoiceId ?? ""
                    DispatchQueue.main.async {
                        viewModel.purchaseNumber = DataHolder.purchaseNumber
                    }

                    let nextStep: () -> Void = {
                        initPaymentsWithNextStep(
                                viewModel: viewModel,
                                navigateCoordinator: navigateCoordinator
                        )
                    }

                    Task {
                        if (DataHolder.renderSavedCards == nil || DataHolder.renderApplePay == nil) {
                            if let result = await getMerchantInfoService() {
                                if (DataHolder.renderApplePay == nil) {
                                    DataHolder.renderApplePay = result.config?.renderApplePayButton
                                }

                                if (DataHolder.renderSavedCards == nil) {
                                    DataHolder.renderSavedCards = result.config?.renderSaveCards
                                }

                                nextStep()

                            } else {
                                nextStep()
                            }
                        } else {
                            nextStep()
                        }
                    }
                },
                onError: {
                    DispatchQueue.main.async {
                        navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
                    }
                }
        )
    }
}

private func initPaymentsWithNextStep(
        viewModel: StartProcessingViewModel,
        navigateCoordinator: AirbaPayCoordinator
) {
    let onApplePayResult: (String?) -> Void = { url in
        if (url != nil) {
            DataHolder.applePayButtonUrl = url
            DispatchQueue.main.async {
                viewModel.applePayUrl = url
            }
        }

        if (DataHolder.isRenderSavedCards()) {
            blGetSavedCards(
                    onSuccess: { result in
                        Task {
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
                        }
                    },
                    onNoCards: {
                        Task {
                            await MainActor.run {
                                viewModel.isLoading = false
                                navigateCoordinator.openHome()
                            }
                        }
                    }
            )
        } else {
            DispatchQueue.main.async {
                viewModel.isLoading = false
                navigateCoordinator.openHome()
            }
        }
    }

    if (DataHolder.isApplePayNative) {
        onApplePayResult(nil)

    } else {
        Task {
            if let result = await getApplePayService() {
                onApplePayResult(result.buttonUrl)
            } else {
                onApplePayResult(nil)
            }
        }
    }
}
