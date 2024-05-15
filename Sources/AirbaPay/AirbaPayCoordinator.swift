//
// Created by Mikhail Belikov on 05.09.2023.
//

import Foundation
import UIKit
import SwiftUI

// https://github.com/alexdremov/PathPresenter?ref=alexdremov.me

public class AirbaPayCoordinator: UIViewController { //todo удали ненужные view классы внизу и перенеси насчет кастомных страниц в initSdk
//public class AirbaPayCoordinator: ObservableObject { //todo remove public и перенеси насчет кастомных страниц в initSdk
//    public var actionOnOpenProcessing: () -> Void
//    public var actionOnCloseProcessing: (Bool?) -> Void
//    public var isCustomSuccessPageView: Bool = false
//    public var isCustomFinalErrorPageView: Bool = false

//    private var uiViewController: UIViewController? = nil
//    @Published var path = PathPresenter.Path()

//    public init(
//        viewController: AirbaPaySdkViewController
////            isCustomSuccessPageView: Bool = false,
////            isCustomFinalErrorPageView: Bool = false,
////            actionOnOpenProcessing: @escaping () -> Void = {},
////            actionOnCloseProcessing: @escaping (Bool?) -> Void = { result in },
////            uiViewController: UIViewController?
//    ) {
//        uiViewController = viewController
////        self.isCustomSuccessPageView = isCustomSuccessPageView
////        self.isCustomFinalErrorPageView = isCustomFinalErrorPageView
////        self.actionOnOpenProcessing = actionOnOpenProcessing
////        self.actionOnCloseProcessing = actionOnCloseProcessing
////        self.uiViewController = uiViewController
////        self.uiViewController = UIViewController()
////        let storyboard = UIStoryboard(name: "Main", bundle: nil)
////        uiViewController = storyboard.instantiateViewController(withIdentifier: "AirbaPayViewController")
//    }

    /* override public func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .white

        let label =  UIButton()
          label.frame = CGRect.init(x: self.view.frame.width/3.5, y: self.view.frame.height/2, width: 180, height: 50)
          label.setTitle("Aaaaa", for: .normal)
          label.backgroundColor = .green
          label.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
      view.addSubview(label)

    }*/

//    @objc func buttonTapped(sender : UIButton) {
//        openTestPage()
//    }
    private var uiNavigationController: UINavigationController? = nil

    public func openTestPage() {
        openPage(content: TestPage1(navigateCoordinator: self))
    }

    public func startProcessing() {
        print("click aaaa")
        LoggerHelper.nextPage(pageName: "StartProcessingView")
        openPage(content: StartProcessingPage(navigateCoordinator: self))
    }

    public func openHome() {
        LoggerHelper.nextPage(pageName: "HomePage")
//        actionOnOpenProcessing()
        openPage(content: HomePage(navigateCoordinator: self))
    }

    public func backToStartPage() {
        LoggerHelper.clear()
        navigationController?.popToRootViewController(animated: false)
        startProcessing()
    }

    public func backToApp(
            result: Bool = false
    ) {
        LoggerHelper.clear()
        navigationController?.popToRootViewController(animated: true)
    }

    public func openAcquiring(
            redirectUrl: String?
    ) {
        LoggerHelper.nextPage(pageName: "AcquiringPage")
        openPage(content: AcquiringPage(navigateCoordinator: self, redirectUrl: redirectUrl))
    }

    public func openSuccess() {
        LoggerHelper.nextPage(pageName: "SuccessPage")

        if DataHolder.isCustomSuccessPageView {
//            actionOnCloseProcessing(true)
//            while !path.isEmpty {
//                path.removeLast()
//            }
        } else {
            openPage(content: SuccessPage(navigateCoordinator: self))
        }
    }

    public func openRepeat() {
        LoggerHelper.nextPage(pageName: "RepeatPage")
        openPage(content: RepeatPage(navigateCoordinator: self))
    }

    public func openErrorPageWithCondition(
            errorCode: Int?
    ) {

        let error = ErrorsCode(code: errorCode ?? 1).getError()

        if (error == ErrorsCode().error_1) {
            LoggerHelper.nextPage(pageName: "ErrorSomethingWrongPage")
            openPage(content: ErrorSomethingWrongPage(navigateCoordinator: self))

        } else if (error.code == ErrorsCode().error_5020.code || errorCode == nil) {
            LoggerHelper.nextPage(pageName: "ErrorFinalPage")

            if DataHolder.isCustomFinalErrorPageView {
//                actionOnCloseProcessing(false)
//                while !path.isEmpty {
//                    path.removeLast()
//                }
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

    private func openPage(content: some View) {
        if !TestAirbaPayStates.isTestApp && uiNavigationController == nil {
            uiNavigationController = UINavigationController(rootViewController: self)

            let window = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first

            window?.makeKeyAndVisible()
            window?.rootViewController = uiNavigationController
        }


        let newVC = UIHostingController(rootView: content)

        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.toolbar?.isHidden = true
        navigationController?.pushViewController(newVC, animated: true)
    }

}

public struct AirbaPayView: View { //todo
    var navigateCoordinator: AirbaPayCoordinator
    var contentView: AnyView?

    public init<RootView: View>(
            navigateCoordinator: AirbaPayCoordinator,
            @ViewBuilder contentView: () -> RootView
    ) {
        self.navigateCoordinator = navigateCoordinator
        self.contentView = AnyView(contentView())
    }

    public var body: some View {
        contentView
//        PathPresenter.RoutingView(
//                path: $navigateCoordinator.path,
//                rootView: { contentView }
//        )
    }
}

public struct AirbaPayNextStepApplePayView: View { // todo
    var navigateCoordinator: AirbaPayCoordinator

    public init(
            navigateCoordinator: AirbaPayCoordinator
    ) {
        self.navigateCoordinator = navigateCoordinator
    }

    public var body: some View {

        SuccessPage(navigateCoordinator: navigateCoordinator)
//        PathPresenter.RoutingView(
//                path: $navigateCoordinator.path,
//                rootView: {
//                    if DataHolder.externalApplePayRedirect?.0 != nil {
//                        AcquiringPage(
//                                navigateCoordinator: navigateCoordinator,
//                                redirectUrl: DataHolder.externalApplePayRedirect?.0!
//                        )
//
//                    } else if DataHolder.externalApplePayRedirect?.1 == true {
//                        SuccessPage(navigateCoordinator: navigateCoordinator)
//
//                    } else {
//                        ErrorSomethingWrongPage(navigateCoordinator: navigateCoordinator)
//                    }
//                }
//        )
    }
}
