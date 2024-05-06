//
//  ExternalPaySavedCard.swift
//
//  Created by Mikhail Belikov on 06.05.2024.
//

import Foundation

public extension AirbaPaySdk {
    
    static func externalPaySavedCard(
        cardId: String,
        isLoading: @escaping (Bool) -> Void,
        navigateCoordinator: AirbaPayCoordinator
    ) {
        DataHolder.isApplePayFlow = false
        
        Task {
            blAuth(
                navigateCoordinator: navigateCoordinator,
                onSuccess: { 
                    blCheckSavedCardNeedCvv(
                            cardId: cardId,
                            toggleCvv: { },
                            isLoading: isLoading,
                            navigateCoordinator: navigateCoordinator
                    )
                    
                }
            )
        }
        
    }
}
