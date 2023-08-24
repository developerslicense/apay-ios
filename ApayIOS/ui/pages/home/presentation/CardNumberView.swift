//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct CardNumberView: View {
        @State var cardNumberText: String
        @State var cardNumberError: String?
        @State var paySystemIcon: String?
//        cardNumberFocusRequester: FocusRequester,
//        dateExpiredFocusRequester: FocusRequester,
    var body: some View {
        ZStack{}

      /*  ViewEditText(
                mask: "AAAA AAAA AAAA AAAA",
                text: cardNumberText,
                regex: Regex(NOT_DIGITS),
                paySystemIcon: paySystemIcon,
                errorTitle: cardNumberError,
                focusRequester: cardNumberFocusRequester,
                placeholder: cardNumber(),
                keyboardActions: KeyboardActions(
                        onNext: {
                            dateExpiredFocusRequester.requestFocus()
                        }
                ),
                keyboardOptions: KeyboardOptions.Default.copy(
                        capitalization: KeyboardCapitalization.None,
                        autoCorrect: false,
                        keyboardType: KeyboardType.Number,
                        imeAction: ImeAction.Next
                ),
                modifierRoot: Modifier.padding(horizontal: 16.dp),
                actionOnTextChanged: { pan ->
                        paySystemIcon: getCardTypeFromNumber(pan).icon
                }
        )*/
    }
}