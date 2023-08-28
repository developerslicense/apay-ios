//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct DateExpiredView: View {
    @State var dateExpiredText: String
    @State var dateExpiredError: String?

    var body: some View {
        let regex: Regex? = try? Regex(RegexConst.NOT_DIGITS)

        ViewEditText(
                text: dateExpiredText,
                errorTitle: dateExpiredError,
                placeholder: dateExpired(),
                regex: regex,
                isDateExpiredMask: true,
                actionOnTextChanged: { date in

                },
                actionClickInfo: nil
        )
    }
}