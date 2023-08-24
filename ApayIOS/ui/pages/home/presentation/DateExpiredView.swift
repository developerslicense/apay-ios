//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct DateExpiredView: View {
    @State var dateExpiredText: String
    @State var dateExpiredError: String?
//        var dateExpiredFocusRequester: FocusRequester
//        var cvvFocusRequester: FocusRequester

    var body: some View {
        let regex: Regex? = try? Regex(RegexConst.NOT_DIGITS)

        ViewEditText(
                text: dateExpiredText,
                errorTitle: dateExpiredError,
                hasFocus: false, //todo
                placeholder: dateExpired(),
                mask: "AA/AA",
                regex: regex,
                isDateExpiredMask: true,
                paySystemIcon: nil,
//                focusRequester: dateExpiredFocusRequester,
                /* keyboardActions: KeyboardActions(
                        onNext: {
                            cvvFocusRequester.requestFocus()
                        }
                ),
                keyboardOptions: KeyboardOptions.Default.copy(
                        capitalization: KeyboardCapitalization.None,
                        autoCorrect: false,
                        keyboardType: KeyboardType.Number,
                        imeAction: ImeAction.Next
                ),*/
//                modifierRoot: modifier,
                actionOnTextChanged: { pan in

                },
                actionClickInfo: nil
        )
    }
}