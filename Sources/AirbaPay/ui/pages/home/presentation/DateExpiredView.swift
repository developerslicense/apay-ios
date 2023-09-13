//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

struct DateExpiredView: View {
    @StateObject var viewModel: HomePageViewModel

    var body: some View {
//        let regex: Regex? = try? Regex(RegexConst.NOT_DIGITS)

        ViewEditText(
                text: viewModel.dateExpiredText,
                errorTitle: viewModel.dateExpiredError,
                placeholder: dateExpired(),
//                regex: regex,
                isDateExpiredMask: true,
                actionOnTextChanged: { date in
                    viewModel.dateExpiredText = date
                },
                actionClickInfo: nil
        )
    }
}
