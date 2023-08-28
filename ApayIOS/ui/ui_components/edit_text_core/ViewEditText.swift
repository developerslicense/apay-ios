//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct ViewEditText: View {
    @State var text: String
    @State var errorTitle: String?
    @State var hasFocus: Bool

    var placeholder: String
    var regex: Regex<AnyRegexOutput>? = nil
    var isDateExpiredMask: Bool = false
    var isCardNumberMask: Bool = false
    var isCvvMask: Bool = false
    var keyboardType: UIKeyboardType = .decimalPad
    var actionOnTextChanged: (String) -> Void
    var actionClickInfo: (() -> Void)?

    var body: some View {

        VStack {
            CoreEditText(
                    text: text,
                    isError: errorTitle != nil,
                    hasFocus: hasFocus,
                    isDateExpiredMask: isDateExpiredMask,
                    isCardNumberMask: isCardNumberMask,
                    isCvvMask: isCvvMask,
                    placeholder: placeholder,
                    regex: regex,
                    keyboardType: keyboardType,
                    actionOnTextChanged: actionOnTextChanged,
                    actionClickInfo: actionClickInfo
            )
        }
    }
}

/*

        if (errorTitle.value != null) {
            Row {
                Icon(
                    painter = painterResource(R.drawable.alarm),
                    contentDescription = "alarm",
                    tint = ColorsSdk.stateError,
                    modifier = Modifier.padding(vertical = 4.dp)
                )
                Text(
                    style = LocalFonts.current.caption400,
                    text = errorTitle.value!!,
                    color = ColorsSdk.stateError,
                    modifier = Modifier.padding(vertical = 4.dp)
                )
            }

        }
    }*/

