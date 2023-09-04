//
// Created by Mikhail Belikov on 01.09.2023.
//

import Foundation
import SwiftUI
import Stinsen

final class NavigateUtils: NavigationCoordinatable {
    let stack = NavigationStack(initial: \NavigateUtils.startPage)

    @Root var startPage = openStartPage
    @Route(.push) var homePage = openHome // todo Root ???
    @Route(.push) var repeatPage = openRepeat
    @Route(.push) var errorPage = openErrorPageWithCondition
    @Route(.push) var successPage = openSuccess
    @Route(.push) var webViewPage = openWebView
//    @Route(.modal) var forgotPassword = makeForgotPassword

    @ViewBuilder func openStartPage() -> some View { // todo надо придумать, что сделать для разделения на тест и реал
        TestPage()
    }

    @ViewBuilder func openHome() -> some View {
        HomePage()
    }

    @ViewBuilder func openRepeat() -> some View {
        RepeatPage()
    }

    @ViewBuilder func openErrorPageWithCondition(
            errorCode: Int?
    ) -> some View {
        let error = ErrorsCode(code: errorCode ?? 1).getError()

        if (error.code == ErrorsCode().error_1.code) {
            ErrorSomethingWrongPage()

        } else if (error.code == ErrorsCode().error_5020.code || errorCode == nil) {
            ErrorFinalPage()

        } else if (error.code == ErrorsCode().error_5999.code && DataHolder.bankCode?.isEmpty == false) {
            ErrorWithInstructionPage()

        } else {
            ErrorPage(errorCode: ErrorsCode(code: errorCode ?? 1))
        }
    }

    @ViewBuilder func openSuccess() -> some View {
        SuccessPage()
    }

    @ViewBuilder func openWebView(
            redirectUrl: String?
    ) -> some View {
        WebViewPage()
    }
}

