//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import Combine
import Alamofire

func createPaymentService(
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
        goods: [AirbaPaySdk.Goods]?,
        settlementPayments: [AirbaPaySdk.SettlementPayment]?
) async -> PaymentCreateResponse? {

    DataHolder.isApplePayFlow = false

    let payForm = PayForm(
            renderApplePay: renderApplePay,
            requestCvv: renderSecurityCvv,
            requestFaceId: renderSecurityBiometry,
            renderSaveCards: renderSavedCards
    )

    let params = PaymentCreateRequest(
            accountId: DataHolder.accountId,
            invoiceId: invoiceId,
            orderNumber: orderNumber,
            language: DataHolder.currentLang == AirbaPaySdk.Lang.RU() ? "ru" : "kz",
            phone: DataHolder.userPhone,
            email: DataHolder.userEmail,
            failureBackUrl: DataHolder.failureBackUrl,
            failureCallback: failureCallback,
            successBackUrl: DataHolder.successBackUrl,
            successCallback: successCallback,
            amount: purchaseAmount,
            settlement: settlementPayments != nil
                    ? SettlementPaymentsRequest(payments: settlementPayments!)
                    : nil,
            autoCharge: autoCharge,
            addParameters: AddParameters(payform: payForm),
            cart: goods
    )

    return await executeRequest(params: params)
}


private func executeRequest(
        params: PaymentCreateRequest,
        cardId: String? = nil
) async -> PaymentCreateResponse? {
    let path = cardId != nil ? "api/v1/payments/" + cardId! : "api/v1/payments"

    do {
        let data = try await NetworkManager.shared.post(
                path: path,
                parameters: params
        )

        let result: PaymentCreateResponse = try Api.parseData(
                data: data,
                path: path,
                method: "POST",
                bodyParams: params
        )

        return result

    } catch let error {
        print(error.localizedDescription)
        return nil
    }
}

