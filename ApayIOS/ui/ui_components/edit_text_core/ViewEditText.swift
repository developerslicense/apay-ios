//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

struct ViewEditText: View {
    @State var text: String = ""
    var errorTitle: String?

    var placeholder: String
//    var regex: Regex<AnyRegexOutput>? = nil
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
                    isDateExpiredMask: isDateExpiredMask,
                    isCardNumberMask: isCardNumberMask,
                    isCvvMask: isCvvMask,
                    placeholder: placeholder,
//                    regex: regex,
                    keyboardType: keyboardType,
                    actionOnTextChanged: actionOnTextChanged,
                    actionClickInfo: actionClickInfo
            )

            if (errorTitle != nil) {
                HStack {
                    Image("icAlarm")

                    Text(errorTitle ?? "")
                            .foregroundColor(ColorsSdk.stateError)
                            .textStyleCaption400()
                            .padding(.top, 4)
                            .padding(.bottom, 4)

                    Spacer()
                }
            }
        }
    }
}


