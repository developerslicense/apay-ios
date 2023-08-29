//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

struct CvvView: View {
    @State var cvvText: String
    @State var cvvError: String?
    var actionClickInfo: () -> Void

    var body: some View {
        let regex: Regex? = try? Regex(RegexConst.NOT_DIGITS)

        ViewEditText(
                text: cvvText,
                errorTitle: cvvError,
                placeholder: cvv(),
                regex: regex,
                isCvvMask: true,
                actionOnTextChanged: { cvv in

                },
                actionClickInfo: actionClickInfo
        )
    }
}
