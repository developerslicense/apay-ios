//
// Created by Mikhail Belikov on 14.09.2023.
//

import Foundation
import SwiftUI

struct CardScannerPage: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator

    var body: some View {

        CardScanner()
                .onDismiss {
                    // Do something when the view dismissed.
                }
                .onError { error in
                    // The 'error' above gives you 'CreditCardScannerError' struct below.
                    print(error)
                }
                .onSuccess { card in
                    // The card above gives you 'CreditCard' struct below.
                    print(card)
                }
    }
}
