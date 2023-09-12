//
// Created by Mikhail Belikov on 05.09.2023.
//

import Foundation
import SwiftUI
import PathPresenter

// https://github.com/alexdremov/PathPresenter?ref=alexdremov.me

public class AirbaPayCoordinator: ObservableObject {
    @Published var path = PathPresenter.Path()

    func startProcessing() {
        path.append(
                StartProcessingView(
                        navigateCoordinator: self,
                        actionClose: {}
                ),
                type: .sheet(onDismiss: {})
        )
    }

    func openHome(cardId: String? = nil) {
        path.append(
                HomePage(
                        navigateCoordinator: self,
                        selectedCardId: cardId
                )
        )
    }

    func backToHome() {
        backToApp()
        openHome()
    }

    func backToApp() {
        while !path.isEmpty {
            path.removeLast()
        }
    }

    func openWebView(redirectUrl: String?) {
        path.append(WebViewPage(navigateCoordinator: self, redirectUrl: redirectUrl))
    }

    func openSuccess() {
        path.append(SuccessPage(navigateCoordinator: self))
    }

    func openRepeat() {
        path.append(RepeatPage(navigateCoordinator: self))
    }

    func openErrorPageWithCondition(errorCode: Int?) {
        let error = ErrorsCode(code: errorCode ?? 1).getError()

        if (error == ErrorsCode().error_1) {
            path.append(ErrorSomethingWrongPage(navigateCoordinator: self))

        } else if (error.code == ErrorsCode().error_5020.code || errorCode == nil) {
            path.append(ErrorFinalPage(navigateCoordinator: self))

        } else if (error.code == ErrorsCode().error_5999.code && DataHolder.bankCode?.isEmpty == false) {
            path.append(ErrorWithInstructionPage(navigateCoordinator: self))

        } else {
            path.append(ErrorPage(errorCode: ErrorsCode(code: errorCode ?? 1), navigateCoordinator: self))
        }
    }

}

public struct AirbaPayView: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    var contentView: AnyView?

    public init<RootView: View>(
            @ObservedObject navigateCoordinator: AirbaPayCoordinator,
            @ViewBuilder contentView: () -> RootView
    ) {
        self.navigateCoordinator = navigateCoordinator
        self.contentView = AnyView(contentView())
    }

    public var body: some View {

        PathPresenter.RoutingView(
                path: $navigateCoordinator.path,
                rootView: { contentView }
        )
    }
}
