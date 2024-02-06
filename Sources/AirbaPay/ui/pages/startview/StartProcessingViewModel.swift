//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation

class StartProcessingViewModel: ObservableObject {
    @MainActor @Published var isLoading: Bool = true
    @MainActor @Published var savedCards: [BankCard] = []
    @MainActor @Published var selectedCard: BankCard? = nil
    @MainActor @Published var applePayUrl: String? = nil

    func authAndLoadData(
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
