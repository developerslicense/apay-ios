//
//  TestDeleteCards.swift
//
//  Created by Mikhail Belikov on 07.02.2024.
//

import Foundation

public func testDelCards(
    accountId: String,
    isLoading: @escaping (Bool) -> Void
) {
    isLoading(true)
    
    let params = AuthRequest(
        password: DataHolder.password,
        paymentId: nil,
        terminalId: DataHolder.terminalId,
        user: DataHolder.shopId
    )
    
    Task {
        if let result = await authService(params: params) {
            DataHolder.accessToken = result.accessToken
            
            if let cards = await getCardsService(accountId: accountId) {
                var index = 0
                
                while index < cards.count {
                    await deleteCardsService(cardId: cards[index].id ?? "")
                    index = index + 1
                }
                
                isLoading(false)

            } else {
                isLoading(false)
            }
            
        } else {
            isLoading(false)
        }
    }
 
}
