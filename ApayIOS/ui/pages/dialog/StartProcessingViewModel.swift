//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation

internal class StartProcessingViewModel: ObservableObject {
    @MainActor @Published var errorMessage = ""
    @MainActor @Published var savedCards: [BankCard] = []

    func fetchAppliances() async {
        await MainActor.run {
            self.errorMessage = ""
        }
        if let res = await NetworkAPI.getAppliances() {
            await MainActor.run {
                self.savedCards = res.map { appliance in
                   BankCard(maskedPan: appliance.brand, typeIcon: "icVisa")
                }
            }
        } else {
            await MainActor.run {
                self.errorMessage = "Fetch data failed"
            }
        }
    }
}