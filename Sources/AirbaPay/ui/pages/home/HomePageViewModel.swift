//
// Created by Mikhail Belikov on 01.09.2023.
//

import Foundation

class HomePageViewModel: ObservableObject {
    @MainActor @Published var isLoading: Bool = false
    @MainActor @Published var cardNumberText: String = ""
    @MainActor @Published var dateExpiredText: String = ""
    @MainActor @Published var cvvText: String = ""

    @MainActor @Published var cardNumberError: String? = nil
    @MainActor @Published var dateExpiredError: String? = nil
    @MainActor @Published var cvvError: String? = nil

    var switchSaveCard: Bool = false

    func changeErrorState(
            cardNumberError: String? = nil,
            dateExpiredError: String? = nil,
            cvvError: String? = nil
    ) {
        Task {
            await MainActor.run {
                self.cardNumberError = cardNumberError
                self.dateExpiredError = dateExpiredError
                self.cvvError = cvvError
            }
        }
    }
}