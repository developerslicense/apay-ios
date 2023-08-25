//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct CardNumberView: View {
    @State var cardNumberText: String
    @State var cardNumberError: String?
    @State var paySystemIcon: String = ""
//    var mask: MaskCardNumber = MaskCardNumber()
//        cardNumberFocusRequester: FocusRequester,
//        dateExpiredFocusRequester: FocusRequester,


    var body: some View {
        let regex: Regex? = try? Regex(RegexConst.NOT_DIGITS)

        ViewEditText(
                text: cardNumberText,
                errorTitle: cardNumberError,
                hasFocus: false, //todo
                placeholder: cardNumber(),
                maskUtils: nil,//MaskUtils(pattern: "AAAA AAAA AAAA AAAA"),
                regex: regex,
                isDateExpiredMask: false,
                isCardNumber: true,
//                focusRequester: cardNumberFocusRequester,
                /* keyboardActions: KeyboardActions(
                        onNext: {
                            dateExpiredFocusRequester.requestFocus()
                        }
                ),*/
                /*keyboardOptions: KeyboardOptions.Default.copy(
                        capitalization: KeyboardCapitalization.None,
                        autoCorrect: false,
                        keyboardType: KeyboardType.Number,
                        imeAction: ImeAction.Next
                ),*/
//                modifierRoot: Modifier.padding(horizontal: 16.dp),
                actionOnTextChanged: { pan in

                },
                actionClickInfo: nil
        )
    }
}