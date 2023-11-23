//
// Created by Mikhail Belikov on 29.08.2023.
//

import SwiftUI
import Foundation

struct InitViewStartProcessingAPay: View {
    var navigateCoordinator: AirbaPayCoordinator
    var appleResult: ApplePayButtonResponse?

    var body: some View {

        VStack {
            ApplePayPage(redirectUrl: appleResult?.buttonUrl, navigateCoordinator: navigateCoordinator)
        }
                .frame(maxWidth: .infinity, maxHeight: appleResult == nil ? 0 : 48)
                .padding(.top, 8)
                .padding(.horizontal, 16)
    }
}
