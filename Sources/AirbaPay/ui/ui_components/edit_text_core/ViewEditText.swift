//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

struct ViewEditText: View {
    @StateObject var viewModel: CoreEditTextViewModel
    var errorTitle: String?

    var placeholder: String
    var isDateExpiredMask: Bool = false
    var isCardNumberMask: Bool = false
    var isCvvMask: Bool = false
    var isText: Bool = false // только для тестовой страницы
    var keyboardType: UIKeyboardType = .decimalPad
    var actionOnTextChanged: (String) -> Void
    var actionClickInfo: (() -> Void)?
    var actionClickScanner: (() -> Void)? = nil

    var body: some View {

        VStack {

            CoreEditText(
                    viewModel: viewModel,
                    isError: errorTitle != nil,
                    isDateExpiredMask: isDateExpiredMask,
                    isCardNumberMask: isCardNumberMask,
                    isCvvMask: isCvvMask,
                    isText: isText,
                    placeholder: placeholder,
                    keyboardType: keyboardType,
                    actionOnTextChanged: actionOnTextChanged,
                    actionClickInfo: actionClickInfo,
                    actionClickScanner: actionClickScanner
            )

            if (errorTitle != nil) {
                HStack {
                    Image("icAlarm", bundle: DataHolder.moduleBundle)

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
