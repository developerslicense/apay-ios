//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import SwiftUI

struct InitViewStartProcessingAPay: View {
    var isLoading: (Bool) -> Void
    var navigateCoordinator: AirbaPayCoordinator

    var body: some View {
        VStack {
            Image("icAPayWhite", bundle: DataHolder.moduleBundle)

        }
                .frame(maxWidth: .infinity)
                .padding()
                .background(ColorsSdk.bgAPAY)
                .cornerRadius(4)
                .padding(.top, 8)
                .padding(.horizontal, 16)
                .onTapGesture {
                    isLoading(true)

                    startPaymentProcessingApplePay(
                            isLoading: isLoading,
                            navigateCoordinator: navigateCoordinator
                    )
                }
    }
}

private func startPaymentProcessingApplePay(
        isLoading: @escaping (Bool) -> Void,
        navigateCoordinator: AirbaPayCoordinator
) {

    Task {

        await startCreatePayment(
                onSuccess: { response in
                    isLoading(false)
                    navigateCoordinator.openApplePay(redirectUrl: response?.buttonUrl)
                },
                onError: { errorCode in
                    isLoading(false)
                    navigateCoordinator.openErrorPageWithCondition(errorCode: errorCode.code)
                }
        )
    }
}

private func startCreatePayment(
        onSuccess: @escaping (ApplePayButtonResponse?) -> Void,
        onError: @escaping (ErrorsCodeBase) -> Void
) async {
    if let result: PaymentCreateResponse = await createPaymentService() {
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
                    onError: onError,
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
        onError: @escaping (ErrorsCodeBase) -> Void,
        onSuccess: @escaping (ApplePayButtonResponse?) -> Void
) async {
    if let result = await getApplePayService() {
        DispatchQueue.main.async { onSuccess(result) }

    } else {
        onError(ErrorsCode().error_1)
    }
}


