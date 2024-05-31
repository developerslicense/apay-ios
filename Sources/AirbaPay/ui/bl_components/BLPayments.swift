//
//  InitPayments.swift
//
//  Created by Mikhail Belikov on 05.02.2024.
//

import Foundation

func blCreatePayment(
        authToken: String,
        failureCallback: String,
        successCallback: String,
        autoCharge: Int = 0,
        purchaseAmount: Double,
        invoiceId: String,
        orderNumber: String,
        renderSecurityCvv: Bool?,
        renderSecurityBiometry: Bool?,
        renderApplePay: Bool?,
        renderSavedCards: Bool?,
        goods: [AirbaPaySdk.Goods]? = nil,
        settlementPayments: [AirbaPaySdk.SettlementPayment]? = nil,
        onSuccess: @escaping (String, String) -> Void,
        onError: @escaping () -> Void
) {

    DataHolder.token = authToken

    Task {

        if let result = await createPaymentService(
                failureCallback: failureCallback,
                successCallback: successCallback,
                autoCharge: autoCharge,
                purchaseAmount: purchaseAmount,
                invoiceId: invoiceId,
                orderNumber: orderNumber,
                renderSecurityCvv: renderSecurityCvv,
                renderSecurityBiometry: renderSecurityBiometry,
                renderApplePay: renderApplePay,
                renderSavedCards: renderSavedCards,
                goods: goods,
                settlementPayments: settlementPayments
        ) {

            if let newToken = await updateAuth(paymentId: result.id!) {
                onSuccess(result.id!, newToken.accessToken ?? "")
            } else {
                onError()
            }

        } else {
            onError()
        }
    }
}

private func loadApplePayButton(
        onApplePayResult: @escaping (String?) -> Void
) {
    Task {
        if let result = await getApplePayService() {
            onApplePayResult(result.buttonUrl)
        } else {
            onApplePayResult(nil)
        }
    }
}
