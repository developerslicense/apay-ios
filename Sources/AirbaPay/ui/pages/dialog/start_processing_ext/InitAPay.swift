//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import SwiftUI

/*struct InitViewStartProcessingAPay: View { // это старый способ инициализации эпплпэя
    var isLoading: (Bool) -> Void
    var navigateCoordinator: AirbaPayCoordinator
    var viewModel: StartProcessingViewModel

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
                    viewModel.applePayUrl = nil

                    startPaymentProcessingApplePay(
                            isLoading: isLoading,
                            navigateCoordinator: navigateCoordinator,
                            onSuccess: { result in
                                viewModel.applePayUrl = result
                            }
                    )
                }
    }
}

func startPaymentProcessingApplePay(
        isLoading: @escaping (Bool) -> Void,
        navigateCoordinator: AirbaPayCoordinator,
        onSuccess: @escaping (String?) -> Void
) {

    Task {

        await startCreatePayment(
                onSuccess: { response in
                    isLoading(false)
//                    navigateCoordinator.openApplePay(redirectUrl: response?.buttonUrl)
                    onSuccess(response?.buttonUrl)

                },
                onError: { errorCode in
                    isLoading(false)
                    navigateCoordinator.openErrorPageWithCondition(errorCode: errorCode.code)
                }
        )
    }
}*/

func startCreatePayment(
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


