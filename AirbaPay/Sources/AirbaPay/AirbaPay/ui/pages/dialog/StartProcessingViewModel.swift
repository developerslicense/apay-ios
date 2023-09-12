//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation

class StartProcessingViewModel: ObservableObject {
    @MainActor @Published var isLoading: Bool = true
    @MainActor @Published var isError: Bool = false
    @MainActor @Published var savedCards: [BankCard] = []
    @MainActor @Published var selectedCard: BankCard? = nil

    func authAndLoadCards() async {
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
            await loadCards()

        } else {
            await MainActor.run {
                isError = true
                isLoading = false
            }
        }

    }

    private func loadCards() async {
        if let res = await getCardsService(phone: DataHolder.userPhone) {
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
