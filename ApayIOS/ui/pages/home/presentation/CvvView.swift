//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct CvvView: View {
    var actionClickInfo: () -> Void
    @State var cvvText: String
    @State var cvvError: String?
//        var cvvFocusRequester: FocusRequester,

    var body: some View {
        ZStack {
        }

//        val focusManager:  LocalFocusManager.current

      /*  ViewEditText(
                text: cvvText,
                regex: Regex(RegexConst.NOT_DIGITS),
                mask: "AAA",
                errorTitle: cvvError,
                focusRequester: cvvFocusRequester,
                placeholder: cvv(),
                keyboardActions: KeyboardActions(
                        onDone: {
                            focusManager.clearFocus(true)
                        }
                ),
                keyboardOptions: KeyboardOptions.Default.copy(
                        capitalization: KeyboardCapitalization.None,
                        autoCorrect: false,
                        keyboardType: KeyboardType.NumberPassword,
                        imeAction: ImeAction.Done
                ),
                modifierRoot: modifier,
                actionOnTextChanged: {},
                actionClickInfo: actionClickInfo,
                visualTransformation: PasswordVisualTransformation()
        )*/
    }
}