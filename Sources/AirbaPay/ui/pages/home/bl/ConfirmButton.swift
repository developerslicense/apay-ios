//
// Created by Mikhail Belikov on 31.08.2023.
//

import Foundation

func startPaymentProcessing(
        isLoading: @escaping (Bool) -> Void,
        saveCard: Bool = false,
        cardNumber: String,
        dateExpired: String? = nil,
        cvv: String? = nil,
        navigateCoordinator: AirbaPayCoordinator
) {

    Task {

        let card = BankCard(
                pan: getNumberCleared(amount: cardNumber),
                expiry: dateExpired,
                name: "Card Holder",
                cvv: cvv ?? ""
        )

        let params = PaymentDefaultRequest(
                cardSave: saveCard,
                email: DataHolder.userEmail,
                sendReceipt: true,
                card: card
        )

        if let entryResponse: PaymentEntryResponse = await paymentDefaultService(params: params) {
            if (entryResponse.errorCode != 0) {
                if (entryResponse.errorCode != 0) {
                    let error = ErrorsCode(code: entryResponse.errorCode ?? 1).getError()
                    DispatchQueue.main.async {
                        navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
                    }

                } else if (entryResponse.isSecure3D == true) {
                    DispatchQueue.main.async {
                        navigateCoordinator.openAcquiring(redirectUrl: entryResponse.secure3D?.action)
                    }

                } else {
                    DispatchQueue.main.async {
                        navigateCoordinator.openSuccess()
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
            }
        }
    }
}