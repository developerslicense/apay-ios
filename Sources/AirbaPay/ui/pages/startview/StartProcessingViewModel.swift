//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation

class StartProcessingViewModel: ObservableObject {
    @MainActor @Published var isLoading: Bool = true
    @MainActor @Published var isError: Bool = false
    @MainActor @Published var savedCards: [BankCard] = []
    @MainActor @Published var selectedCard: BankCard? = nil
    @MainActor @Published var applePayUrl: String? = nil

    func authAndLoadData() async {
        await MainActor.run {
            isLoading = true
            self.isError = false
        }

        let authParams = AuthRequest(
                password: DataHolder.password,
                paymentId: nil,
                terminalId: DataHolder.terminalId,
                user: DataHolder.shopId
        )

        if let res = await authService(params: authParams) {
            await MainActor.run {
                DataHolder.accessToken = res.accessToken

            }
            await startCreatePayment(
                    onSuccess: { result in
                        DispatchQueue.main.async {
                            self.applePayUrl = result?.buttonUrl
                        }
                    },
                    onError: { e in
                        DispatchQueue.main.async {
                            //  self.isError = true
                            self.isLoading = false
                        }
                    }
            )
            await loadCards()

        } else {
            await startCreatePayment(
                    onSuccess: { result in
                        DispatchQueue.main.async {
                            self.applePayUrl = result?.buttonUrl
                        }
                    },
                    onError: { e in
                    }
            )
            await MainActor.run {
                isError = true
                isLoading = false
            }
        }

    }

    private func loadCards() async {
        if let res = await getCardsService(accountId: DataHolder.accountId) {
            await MainActor.run {
                isLoading = false
                savedCards = res

                if (!res.isEmpty) {
                    selectedCard = res[0]
                }
            }

        } else {
            await MainActor.run {
                isLoading = false
            }
        }
    }
}
