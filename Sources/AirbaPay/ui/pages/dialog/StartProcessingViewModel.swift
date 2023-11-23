//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation

class StartProcessingViewModel: ObservableObject {
    @MainActor @Published var isLoading: Bool = true
    @MainActor @Published var isError: Bool = false
    @MainActor @Published var savedCards: [BankCard] = []
    @MainActor @Published var selectedCard: BankCard? = nil
    @MainActor @Published var appleResult: ApplePayButtonResponse? = nil

    func authAndLoadData() async {
        await MainActor.run {
            isLoading = true
            self.isError = false
        }

        let firstAuthParams = AuthRequest(
                password: DataHolder.password,
                paymentId: nil,
                terminalId: DataHolder.terminalId,
                user: DataHolder.shopId
        )

        if let res = await authService(params: firstAuthParams) {
            await MainActor.run {
                DataHolder.accessToken = res.accessToken
            }
        }

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

                await loadCards()

                let tempAppleResult = await getApplePayService()
                await MainActor.run {
                    appleResult = tempAppleResult
                }

            } else {
                await MainActor.run {
                    isError = true
                    isLoading = false
                }
            }

        } else {
            await MainActor.run {
                isLoading = false
                isError = true
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
