//
// Created by Mikhail Belikov on 05.09.2023.
//

import Foundation
import SwiftUI
import PathPresenter

// https://github.com/alexdremov/PathPresenter?ref=alexdremov.me

public class AirbaPayCoordinator: ObservableObject {
    public var actionOnOpenProcessing: () -> Void
    public var actionOnCloseProcessing: (Bool?) -> Void
    public var isCustomSuccessPageView: Bool = false
    public var isCustomFinalErrorPageView: Bool = false
    @Published var path = PathPresenter.Path()

    public init(
            isCustomSuccessPageView: Bool = false,
            isCustomFinalErrorPageView: Bool = false,
            actionOnOpenProcessing: @escaping () -> Void = {},
            actionOnCloseProcessing: @escaping (Bool?) -> Void = { result in }
    ) {
        self.isCustomSuccessPageView = isCustomSuccessPageView
        self.isCustomFinalErrorPageView = isCustomFinalErrorPageView
        self.actionOnOpenProcessing = actionOnOpenProcessing
        self.actionOnCloseProcessing = actionOnCloseProcessing
    }

    public func startProcessing() {
        LoggerHelper.nextPage(pageName: "StartProcessingView")
        path.append(StartProcessingView(navigateCoordinator: self))
    }

    public func openHome() {
        LoggerHelper.nextPage(pageName: "HomePage")
        onBack()
        actionOnOpenProcessing()
        path.append(HomePage(navigateCoordinator: self))
    }

    public func backToStartPage() {
        LoggerHelper.clear()
        while path.count > 0 {
            path.removeLast()
        }
        startProcessing()
    }

    public func backToApp(
            result: Bool? = nil
    ) {
        LoggerHelper.clear()
        while !path.isEmpty {
            path.removeLast()
        }
        actionOnCloseProcessing(result)
        DataHolder.backToStoryboard?()
    }

    func onBack() {
        LoggerHelper.onBackPressed()
        if !path.isEmpty {
            path.removeLast()
        }
    }

    public func openAcquiring(redirectUrl: String?) {
        onBack()
        LoggerHelper.nextPage(pageName: "AcquiringPage")
        path.append(AcquiringPage(navigateCoordinator: self, redirectUrl: redirectUrl))
    }

    public func openSuccess() {
        LoggerHelper.nextPage(pageName: "SuccessPage")

        if isCustomSuccessPageView {
            actionOnCloseProcessing(true)
            while !path.isEmpty {
                path.removeLast()
            }
        } else {
            path.append(SuccessPage(navigateCoordinator: self))
        }
    }

    public func openRepeat() {
        LoggerHelper.nextPage(pageName: "RepeatPage")
        path.append(RepeatPage(navigateCoordinator: self))
    }

    public func openErrorPageWithCondition(errorCode: Int?) {
        while path.count > 0 {
            path.removeLast()
        }

        let error = ErrorsCode(code: errorCode ?? 1).getError()

        if (error == ErrorsCode().error_1) {
            path.append(ErrorSomethingWrongPage(navigateCoordinator: self))

        } else if (error.code == ErrorsCode().error_5020.code || errorCode == nil) {
            LoggerHelper.nextPage(pageName: "ErrorFinalPage")

            if isCustomFinalErrorPageView {
                actionOnCloseProcessing(false)
                while !path.isEmpty {
                    path.removeLast()
                }
            } else {
                path.append(ErrorFinalPage(navigateCoordinator: self))
            }

        } else if (error.code == ErrorsCode().error_5999.code && DataHolder.bankCode?.isEmpty == false) {
            LoggerHelper.nextPage(pageName: "ErrorWithInstructionPage")
            path.append(ErrorWithInstructionPage(navigateCoordinator: self))

        } else {
            LoggerHelper.nextPage(pageName: "ErrorPage")
            path.append(ErrorPage(errorCode: ErrorsCode(code: errorCode ?? 1), navigateCoordinator: self))
        }
    }

    public func openTestApplePaySwiftUi() {
        let applePay = ApplePayManager(navigateCoordinator: self)

        path.append(TestSwiftUiApplePayPage(
                navigateCoordinator: self,
                applePay: applePay
        ))
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

public struct AirbaPayNextStepApplePayView: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator

    public init(
            @ObservedObject navigateCoordinator: AirbaPayCoordinator
    ) {
        self.navigateCoordinator = navigateCoordinator
    }

    public var body: some View {

        PathPresenter.RoutingView(
                path: $navigateCoordinator.path,
                rootView: {
                    if DataHolder.externalApplePayRedirect?.0 != nil {
                        AcquiringPage(
                                navigateCoordinator: navigateCoordinator,
                                redirectUrl: DataHolder.externalApplePayRedirect?.0!
                        )

                    } else if DataHolder.externalApplePayRedirect?.1 == true {
                        SuccessPage(navigateCoordinator: navigateCoordinator)

                    } else {
                        ErrorSomethingWrongPage(navigateCoordinator: navigateCoordinator)
                    }
                }
        )
    }
}
