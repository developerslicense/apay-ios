//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation

public class StartProcessingViewModel: ObservableObject {
    @MainActor @Published public var isLoading: Bool = true
    @MainActor @Published public var applePayUrl: String? = nil

    public init(
            isLoading: Bool,
            applePayUrl: String?
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
}
