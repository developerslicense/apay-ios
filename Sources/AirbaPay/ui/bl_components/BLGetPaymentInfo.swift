//
//  BLGetPaymentInfo.swift
//  AirbaPaySdk
//
//  Created by Mikhail Belikov on 29.05.2024.
//

import Foundation

func blGetPaymentInfo(
        onSuccess: @escaping (PaymentEntryResponse) -> Void,
        onError: @escaping () -> Void
) {
    Task {
        if let result = await getPaymentService() {
            DataHolder.purchaseAmount = result.amount ?? 0.0
            DataHolder.purchaseAmountFormatted = Money.initDouble(amount: DataHolder.purchaseAmount).getFormatted()
            DataHolder.orderNumber = result.orderNumber ?? ""
            if result.invoiceId != nil {
                DataHolder.invoiceId = result.invoiceId ?? ""
            }
            if result.accountId != nil {
                DataHolder.accountId = result.accountId ?? ""
            }
            DataHolder.renderSecurityCvv = result.addParameters?.payform?.requestCvv
            DataHolder.renderSecurityBiometry = result.addParameters?.payform?.requestFaceId
            DataHolder.renderSavedCards = result.addParameters?.payform?.renderSaveCards
            DataHolder.renderApplePay = result.addParameters?.payform?.renderApplePay

            DataHolder.failureBackUrl = result.failureBackUrl ?? DataHolder.failureBackUrl
            DataHolder.successBackUrl = result.successBackUrl ?? DataHolder.successBackUrl

            onSuccess(result)

        } else {
            onError()
        }
    }
}
