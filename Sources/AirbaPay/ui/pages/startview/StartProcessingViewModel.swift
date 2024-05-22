//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation

class StartProcessingViewModel: ObservableObject {
    @MainActor @Published var isLoading: Bool = true
    @MainActor @Published var savedCards: [BankCard] = []
    @MainActor @Published var selectedCard: BankCard? = nil
    @MainActor @Published var applePayUrl: String? = nil

    init(
            isLoading: Bool = true,
            applePayUrl: String? = nil
    ) {
        Task {
            await MainActor.run {
                self.isLoading = isLoading
                self.applePayUrl = applePayUrl
            }
        }
    }
}
