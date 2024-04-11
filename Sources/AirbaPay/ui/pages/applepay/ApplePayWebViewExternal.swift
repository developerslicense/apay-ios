//
//  ApplePayExternalWebView.swift
//
//  Created by Mikhail Belikov on 26.03.2024.
//


import Foundation
import SwiftUI
import WebKit
import Combine
import UIKit

public struct ApplePayWebViewExternal: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    @ObservedObject var applePayViewModel: ApplePayViewModel


    public init(
            redirectFromStoryboardToSwiftUi: (() -> Void)? = nil,
            backToStoryboard: (() -> Void)? = nil,
            @ObservedObject navigateCoordinator: AirbaPayCoordinator,
            @ObservedObject applePayViewModel: ApplePayViewModel
    ) {
        self.navigateCoordinator = navigateCoordinator
        DataHolder.redirectFromStoryboardToSwiftUi = redirectFromStoryboardToSwiftUi
        DataHolder.backToStoryboard = backToStoryboard
        DataHolder.isApplePayFlow = true
        self.applePayViewModel = applePayViewModel
    }

    public var body: some View {

        VStack {
            if applePayViewModel.appleUrlResult != nil {

                ZStack {

                    SwiftUIWebView(
                            url: applePayViewModel.appleUrlResult,
                            navigateCoordinator: navigateCoordinator
                    )
                    ColorsSdk.gray30
                    ColorsSdk.bgMain
                }
            }
        }.frame(height: 0.1)
    }
}

private struct SwiftUIWebView: UIViewRepresentable {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    @ObservedObject var viewModel: WebViewModel
    let webView: WKWebView

    init(
            url: String?,
            navigateCoordinator: AirbaPayCoordinator
    ) {

        self.navigateCoordinator = navigateCoordinator
        viewModel = WebViewModel(link: url ?? "https://")
        webView = WKWebView(frame: .zero)
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
    }

    func makeUIView(context: UIViewRepresentableContext<SwiftUIWebView>) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        if let url = URL(string: viewModel.link) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        @ObservedObject var navigateCoordinator: AirbaPayCoordinator
        private var viewModel: WebViewModel
        private var isRedirected: Bool = false

        init(
                @ObservedObject navigateCoordinator: AirbaPayCoordinator,
                viewModel: WebViewModel
        ) {
            self.navigateCoordinator = navigateCoordinator
            self.viewModel = viewModel
        }


        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) { // это автоклик

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {

                let js = """
                             var parentDOM = document.getElementById('root');
                             parentDOM.getElementsByClassName('apple-pay-btn')[0].click();
                         """

                webView.evaluateJavaScript(js, completionHandler: nil)
            })
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> ()) {

            if (navigationAction.navigationType == .other && !isRedirected) {
                decisionHandler(.allow)

                let url = navigationAction.request.url?.absoluteString ?? ""
                Logger.log(
                        message: "ApplePayWebViewExternal redirectUrl",
                        url: url
                )

                if (url).contains("acquiring-api") == true {
                    Logger.log(
                            message: "ApplePayWebViewExternal redirect to acquiring",
                            url: url
                    )
                    DataHolder.externalApplePayRedirect = (url, false)
                    redirectTo(
                            defaultRedirectAction: {
                                self.navigateCoordinator.openAcquiring(redirectUrl: url)
                            }
                    )
                } else if (url).contains("success") == true {
                    Logger.log(
                            message: "ApplePayWebViewExternal openSuccess",
                            url: url
                    )
                    DataHolder.externalApplePayRedirect = (nil, true)
                    redirectTo(
                            defaultRedirectAction: {
                                self.navigateCoordinator.openSuccess()
                            }
                    )

                } else if (url).contains("failure") == true || (url).contains("error") == true {
                    Logger.log(
                            message: "ApplePayWebViewExternal openErrorPageWithCondition",
                            url: url
                    )
                    DataHolder.externalApplePayRedirect = (nil, false)
                    redirectTo(
                            defaultRedirectAction: {
                                self.navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
                            }
                    )
                }

                return

            }

            decisionHandler(.allow)
        }

        func redirectTo(
                defaultRedirectAction: () -> Void
        ) {
            isRedirected = true

            if DataHolder.redirectFromStoryboardToSwiftUi != nil {
                DataHolder.redirectFromStoryboardToSwiftUi!()
            } else {
                defaultRedirectAction()
            }
        }
    }

    func makeCoordinator() -> SwiftUIWebView.Coordinator {
        Coordinator(
                navigateCoordinator: navigateCoordinator,
                viewModel: viewModel
        )
    }
}

private class WebViewModel: ObservableObject {
    @Published var link: String
    @Published var didFinishLoading: Bool = false

    init(link: String) {
        self.link = link
    }
}

