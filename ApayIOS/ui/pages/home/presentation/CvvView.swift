//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct CvvView: View {
    @State var cvvText: String
    @State var cvvError: String?
//        var cvvFocusRequester: FocusRequester,
    var actionClickInfo: () -> Void

    var body: some View {
        let regex: Regex? = try? Regex(RegexConst.NOT_DIGITS)

//        val focusManager:  LocalFocusManager.current

        ViewEditText(
                text: cvvText,
                errorTitle: cvvError,
                hasFocus: false, //todo
                placeholder: cvv(),
//                mask: "AAA",
                regex: regex,
                isDateExpiredMask: false,
                isCardNumber: false,
//                focusRequester: cvvFocusRequester,
                /*keyboardActions: KeyboardActions(
                        onDone: {
                            focusManager.clearFocus(true)
                        }
                ),*/
                /*keyboardOptions: KeyboardOptions.Default.copy(
                        capitalization: KeyboardCapitalization.None,
                        autoCorrect: false,
                        keyboardType: KeyboardType.NumberPassword,
                        imeAction: ImeAction.Done
                ),*/
//                modifierRoot: modifier,
                actionOnTextChanged: { cvv in

                },
                actionClickInfo: actionClickInfo
//                visualTransformation: PasswordVisualTransformation()
        )
    }
}