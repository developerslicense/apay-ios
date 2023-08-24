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
        ZStack{}
        /*ViewEditText(
                text: dateExpiredText,
                mask: "AA/AA",
                isDateExpiredMask: true,
                regex: Regex(RegexConst.NOT_DIGITS),
                errorTitle: dateExpiredError,
                focusRequester: dateExpiredFocusRequester,
                placeholder: dateExpired(),
                keyboardActions: KeyboardActions(
                        onNext: {
                            cvvFocusRequester.requestFocus()
                        }
                ),
                keyboardOptions: KeyboardOptions.Default.copy(
                        capitalization: KeyboardCapitalization.None,
                        autoCorrect: false,
                        keyboardType: KeyboardType.Number,
                        imeAction: ImeAction.Next
                ),
                modifierRoot: modifier,
                actionOnTextChanged: {}
        )*/
    }
}