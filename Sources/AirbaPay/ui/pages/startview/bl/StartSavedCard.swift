//
//  StartSavedCard.swift
//
//  Created by Mikhail Belikov on 18.01.2024.
//

import Foundation

func startSavedCard(
        cardId: String,
        cvv: String,
        isLoading: @escaping (Bool) -> Void,
        on3DS: @escaping (String?) -> Void,
        onSuccess: @escaping () -> Void,
        onError: @escaping (ErrorsCodeBase) -> Void
) async {
    let params = PaymentSavedCardRequest(cvv: cvv)
    if let result = await paymentSavedCardService(
            cardId: cardId,
            params: params
    ) {
        if result.status == "new" {
            DispatchQueue.main.async { isLoading(false) }

        } else if result.status == "success"
                          || result.status == "auth" {
            DispatchQueue.main.async { onSuccess() }

        } else if result.status == "secure3D" {
            DispatchQueue.main.async { on3DS(result.secure3D?.action) }

        } else {
            DispatchQueue.main.async { onError(ErrorsCode().error_1) }
        }

    } else {
        DispatchQueue.main.async { onError(ErrorsCode().error_1) }
    }
}
