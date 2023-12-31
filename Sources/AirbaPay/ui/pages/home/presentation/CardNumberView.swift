//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

struct CardNumberView: View {
    @StateObject var viewModel: HomePageViewModel
    @StateObject var editTextViewModel: CoreEditTextViewModel
    @State var paySystemIcon: String = ""
    var actionClickScanner: (() -> Void)?

    var body: some View {
//        let regex: Regex? = try? Regex(RegexConst.NOT_DIGITS)

        ViewEditText(
                viewModel: editTextViewModel,
                errorTitle: viewModel.cardNumberError,
                placeholder: cardNumber(),
//                regex: regex,
                isCardNumberMask: true,
                actionOnTextChanged: { pan in
                    viewModel.cardNumberText = pan
                },
                actionClickInfo: nil,
                actionClickScanner: actionClickScanner
        )
    }
}
