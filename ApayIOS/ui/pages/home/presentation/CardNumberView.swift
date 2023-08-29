//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

struct CardNumberView: View {
    @State var cardNumberText: String
    @State var cardNumberError: String?
    @State var paySystemIcon: String = ""

    var body: some View {
        let regex: Regex? = try? Regex(RegexConst.NOT_DIGITS)

        ViewEditText(
                text: cardNumberText,
                errorTitle: cardNumberError,
                placeholder: cardNumber(),
                regex: regex,
                isCardNumberMask: true,
                actionOnTextChanged: { pan in

                },
                actionClickInfo: nil
        )
    }
}
