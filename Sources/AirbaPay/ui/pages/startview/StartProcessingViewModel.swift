//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation

public class StartProcessingViewModel: ObservableObject {
    @MainActor @Published public var isLoading: Bool = true
    @MainActor @Published public var applePayUrl: String? = nil

    public init(
            isLoading: Bool = true,
            applePayUrl: String? = nil
    ) {
        self.isLoading = isLoading
        self.applePayUrl = applePayUrl
    }

    public func startAuth(
            onSuccess: @escaping ()-> Void,
            onError: @escaping ()-> Void

    ) async {
        await MainActor.run {
            isLoading = true
        }

        let authParams = AuthRequest(
                password: DataHolder.password,
                paymentId: nil,
                terminalId: DataHolder.terminalId,
                user: DataHolder.shopId
        )

        if let res = await authService(params: authParams) {
            DispatchQueue.main.async {
                onSuccess()
            }

        } else {
            await MainActor.run {
                isLoading = false
                onError()
            }
        }

    }

    public func onAppear(
            viewModel: StartProcessingViewModel,
            navigateCoordinator: AirbaPayCoordinator
    ) {
        DataHolder.isApplePayFlow = true
        Task {
            await startProcessingViewModel.startAuth(
                    onSuccess: {
                        AirbaPay.fetchMerchantsWithNextStep(
                                viewModel: startProcessingViewModel,
                                navigateCoordinator: navigateCoordinator
                        )
                    },
                    onError: {
                        navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
                    }
            )
        }
    }
}
