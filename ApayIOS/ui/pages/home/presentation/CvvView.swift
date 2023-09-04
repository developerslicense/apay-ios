//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

struct CvvView: View {
    @StateObject var viewModel: HomePageViewModel
    var actionClickInfo: () -> Void

    var body: some View {
//        let regex: Regex? = try? Regex(RegexConst.NOT_DIGITS)

        ViewEditText(
                text: viewModel.cvvText,
                errorTitle: viewModel.cvvError,
                placeholder: cvv(),
//                regex: regex,
                isCvvMask: true,
                actionOnTextChanged: { cvv in
                    viewModel.cvvText = cvv
                },
                actionClickInfo: actionClickInfo
        )
    }
}
