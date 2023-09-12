//
// Created by Mikhail Belikov on 31.08.2023.
//

import Foundation

func checkValid(
        cardNumber: String?,
        dateExpired: String?,
        cvv: String?
) -> (errorCardNumber: String?, errorDateExpired: String?, errorCvv: String?) {
    var errorCardNumber: String? = nil
    var errorDateExpired: String? = nil
    var errorCvv: String? = nil

    if (cardNumber == nil || cardNumber?.isEmpty == true) {
        errorCardNumber = needFillTheField()

    } else if (!validateCardNumWithLuhnAlgorithm(number: cardNumber)) {
        errorCardNumber = wrongCardNumber()
    }

    if (dateExpired == nil || dateExpired?.isEmpty == true) {
        errorDateExpired = needFillTheField()

    } else if (!isDateValid(value: dateExpired)) {
        errorDateExpired = wrongDate()
    }

    if (cvv == nil || cvv?.isEmpty == true) {
        errorCvv = needFillTheField()

    } else if ((cvv?.count ?? 0) < 3) {
        errorCvv = wrongCvv()
    }

    return (errorCardNumber, errorDateExpired, errorCvv)
}


func startPaymentProcessing(
        isLoading: @escaping (Bool) -> Void,
        saveCard: Bool = false,
        cardNumber: String,
        dateExpired: String? = nil,
        cvv: String? = nil,
        navigateCoordinator: AirbaPayCoordinator
) {

    Task {
        let cardSaved = BankCard(
                pan: getNumberCleared(amount: cardNumber),
                expiry: dateExpired,
                name: "Card Holder",
                cvv: cvv
        )

        await startCreatePayment(
                cardSaved: cardSaved,
                saveCardSaved: saveCard,
                on3DS: { secure3D in
                    isLoading(false)
                    navigateCoordinator.openWebView(redirectUrl: secure3D?.action)
                },
                onSuccess: {
                    isLoading(false)
                    navigateCoordinator.openSuccess()
                },
                onError: { errorCode in
                    isLoading(false)
                    navigateCoordinator.openErrorPageWithCondition(errorCode: errorCode.code)
                }
        )
    }
}

private func startCreatePayment(
        cardSaved: BankCard,
        saveCardSaved: Bool,
        on3DS: @escaping (Secure3D?) -> Void,
        onSuccess: @escaping () -> Void,
        onError: @escaping (ErrorsCodeBase) -> Void
) async {
    if let result: PaymentCreateResponse = await createPaymentService(saveCard: saveCardSaved) {
        let authParams = AuthRequest(
                password: DataHolder.password,
                paymentId: result.id,
                terminalId: DataHolder.terminalId,
                user: DataHolder.shopId
        )

        if let res = await authService(params: authParams) {
            await MainActor.run {
                DataHolder.accessToken = res.accessToken

            }

            await onSuccessAuth(
                    saveCardSaved: saveCardSaved,
                    cardSaved: cardSaved,
                    onError: onError,
                    on3DS: on3DS,
                    onSuccess: onSuccess
            )

        } else {
            onError(ErrorsCode().error_1)
        }

    } else {
        onError(ErrorsCode().error_1)
    }
}

private func onSuccessAuth(
        saveCardSaved: Bool,
        cardSaved: BankCard,
        onError: @escaping (ErrorsCodeBase) -> Void,
        on3DS: @escaping (Secure3D?) -> Void,
        onSuccess: @escaping () -> Void
) async {
    let params = PaymentEntryRequest(
            cardSave: saveCardSaved,
            email: DataHolder.userEmail,
            sendReceipt: DataHolder.userEmail != nil,
            card: cardSaved
    )

    if let entryResponse = await paymentAccountEntryService(params: params) {
        if (entryResponse.errorCode != 0) {
            let error = ErrorsCode(code: entryResponse.errorCode ?? 1).getError()
            DispatchQueue.main.async { onError(error) }

        } else if (entryResponse.isSecure3D == true) {
            DispatchQueue.main.async { on3DS(entryResponse.secure3D) }

        } else {
            DispatchQueue.main.async { onSuccess() }
        }

    } else {
        onError(ErrorsCode().error_1)
    }

}
