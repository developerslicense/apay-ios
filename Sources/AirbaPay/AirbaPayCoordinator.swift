//
// Created by Mikhail Belikov on 05.09.2023.
//

import Foundation
import UIKit
import SwiftUI

// https://github.com/alexdremov/PathPresenter?ref=alexdremov.me

class AirbaPayCoordinator: UIViewController {

    var navigation: UINavigationController? = nil
    var applePay: ApplePayManager? = nil

    init() {
        super.init(nibName: nil, bundle: nil)
        applePay = ApplePayManager(navigateCoordinator: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startProcessing() {
        LoggerHelper.nextPage(pageName: "StartProcessingView")
        openPage(content: StartProcessingPage(navigateCoordinator: self, applePay: applePay!))
    }

    func startProcessingWebView(
        redirectUrl: String?
    ) {
        LoggerHelper.nextPage(pageName: "ExternalStandardFlowWebView")
        openPage(content: ExternalStandardFlowWebView(navigateCoordinator: self, redirectUrl: redirectUrl))
    }

    func openHome() {
        LoggerHelper.nextPage(pageName: "HomePage")
        openPage(content: HomePage(navigateCoordinator: self, applePay: applePay!))
    }

    func backToStartPage() {
        LoggerHelper.clear()
        startProcessing()
    }

    func backToApp(
            result: Bool = false
    ) {
        LoggerHelper.clear()
        DataHolder.actionOnCloseProcessing?(result, navigation ?? UINavigationController(rootViewController: self))
    }

    func openAcquiring(
            redirectUrl: String?
    ) {
        LoggerHelper.nextPage(pageName: "AcquiringPage")
        openPage(content: AcquiringPage(navigateCoordinator: self, redirectUrl: redirectUrl))
    }

    func openSuccess() {
        LoggerHelper.nextPage(pageName: "SuccessPage")

        if DataHolder.openCustomPageSuccess != nil {
            navigationController?.popToRootViewController(animated: false)
            DataHolder.openCustomPageSuccess!()
        } else {
            openPage(content: SuccessPage(navigateCoordinator: self))
        }
    }

    func openRepeat() {
        LoggerHelper.nextPage(pageName: "RepeatPage")
        openPage(content: RepeatPage(navigateCoordinator: self))
    }

    func openErrorPageWithCondition(
            errorCode: Int?
    ) {

        let error = ErrorsCode(code: errorCode ?? 1).getError()

        if (error == ErrorsCode().error_1) {
            LoggerHelper.nextPage(pageName: "ErrorSomethingWrongPage")
            openPage(content: ErrorSomethingWrongPage(navigateCoordinator: self))

        } else if (error.code == ErrorsCode().error_5020.code || errorCode == nil) {
            LoggerHelper.nextPage(pageName: "ErrorFinalPage")

            if DataHolder.openCustomPageFinalError != nil {
                navigationController?.popToRootViewController(animated: false)
                DataHolder.openCustomPageFinalError!()
            } else {
                openPage(content: ErrorFinalPage(navigateCoordinator: self))
            }

        } else if (error.code == ErrorsCode().error_5999.code && DataHolder.bankCode?.isEmpty == false) {
            LoggerHelper.nextPage(pageName: "ErrorWithInstructionPage")
            openPage(content: ErrorWithInstructionPage(navigateCoordinator: self))

        } else {
            LoggerHelper.nextPage(pageName: "ErrorPage")
            openPage(content: ErrorPage(
                    errorCode: ErrorsCode(code: errorCode ?? 1),
                    navigateCoordinator: self)
            )
        }
    }

    func openPage(content: some View) {
        DispatchQueue.main.async {

            if self.navigation == nil {
                if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {

                    self.navigation = UINavigationController(rootViewController: self)
                    window.rootViewController = self.navigation
                }
            }

            let newVC = UIHostingController(rootView: content)

            self.navigationController?.setToolbarHidden(true, animated: false)
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.toolbar?.isHidden = true
            self.navigationController?.popViewController(animated: false)
            self.navigationController?.pushViewController(newVC, animated: false)
        }
    }

}
