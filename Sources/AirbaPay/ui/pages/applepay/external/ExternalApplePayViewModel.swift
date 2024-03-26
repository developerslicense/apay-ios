//
//  ExternalApplePayViewModel.swift
//
//  Created by Mikhail Belikov on 26.03.2024.
//

import Foundation

class ExternalApplePayViewModel: ObservableObject {
    @MainActor @Published public var applePayUrl: String? = nil
 
    public func fetchData(
        navigateCoordinator: AirbaPayCoordinator,
        isLoading: @escaping (Bool) -> Void
    ) {
        Task {
            isLoading(true)
            
            let authParams = AuthRequest(
                password: DataHolder.password,
                paymentId: nil,
                terminalId: DataHolder.terminalId,
                user: DataHolder.shopId
            )
            
            if let resAuth = await authService(params: authParams) {
                
                if let result = await getMerchantInfoService() {
                    DataHolder.featureSavedCards = result.config?.renderSaveCards ?? false
                    DataHolder.featureApplePay = result.config?.renderApplePayButton ?? false
                }
                
                initPayments(
                    onApplePayResult: { url in
                        DataHolder.applePayButtonUrl = url
                        
                        Task {
                            if (url != nil) {
                                await MainActor.run {
                                    self.applePayUrl = url
                                }
                            }
                            
                            isLoading(false)
                            
                        }
                    },
                    navigateCoordinator: navigateCoordinator
                )
                
            } else {
                isLoading(false)
            }
        }
    }
}
