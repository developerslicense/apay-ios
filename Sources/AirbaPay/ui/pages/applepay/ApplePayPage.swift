//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI
import WebKit
import Combine

struct ApplePayPage: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    @State var showDialogExit: Bool = false
    private var redirectUrl: String?

    init(
            redirectUrl: String?,
            @ObservedObject navigateCoordinator: AirbaPayCoordinator
    ) {
        self.navigateCoordinator = navigateCoordinator
        self.redirectUrl = redirectUrl ?? "https://"
    }

    var body: some View {
        VStack {
            VStack {
                ViewToolbar(
                        title: "",
                        actionClickBack: { showDialogExit = true }
                )
                        .frame(maxWidth: .infinity, alignment: .leading)
            }

            ZStack {
                ColorsSdk.gray30
                ColorsSdk.bgMain

                SwiftUIWebView(
                        url: redirectUrl,
                        navigateCoordinator: navigateCoordinator
                )


                ColorsSdk.gray30
                ColorsSdk.bgMain
                ProgressBarView()
            }
        }
                .modifier(
                        Popup(
                                isPresented: showDialogExit,
                                content: {
                                    DialogExit(
                                            onDismissRequest: { showDialogExit = false },
                                            backToApp: { navigateCoordinator.backToApp() }
                                    )
                                })
                )
                .onTapGesture(perform: { showDialogExit = false })
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

        init(
                @ObservedObject navigateCoordinator: AirbaPayCoordinator,
                viewModel: WebViewModel
        ) {
            self.navigateCoordinator = navigateCoordinator
            self.viewModel = viewModel
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                let js = """
                             var parentDOM = document.getElementById('root');
                             parentDOM.getElementsByClassName('apple-pay-btn')[0].click();
                         """

                webView.evaluateJavaScript(js, completionHandler: nil)
            })
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> ()) {

            if (navigationAction.navigationType == .other) {
                decisionHandler(.allow)

                if (navigationAction.request.url?.absoluteString ?? "").contains("acquiring-api") == true {
                    navigateCoordinator.openAcquiring(redirectUrl: navigationAction.request.url?.absoluteString)
                }

                return

            } else {
                if let redirectedUrl = navigationAction.request.url {

                    if redirectedUrl.absoluteString.contains("status=auth") == true ||
                               redirectedUrl.absoluteString.contains("status=success") == true {
                        navigateCoordinator.openSuccess()

                    } else if redirectedUrl.absoluteString.contains("status=error") == true {
                        let temp = redirectedUrl.absoluteString.components(separatedBy: "&") ?? []
                        let result = temp.first { text in
                            text.contains("errorCode")
                        }

                        let errorCode: String = result?.components(separatedBy: "=")[1] ?? "1"
                        let errorCodeInt: Int? = Int(errorCode)

                        navigateCoordinator.openErrorPageWithCondition(errorCode: errorCodeInt)

                    } else {
                        decisionHandler(.allow)
                        return
                    }
                }
            }

            decisionHandler(.allow)
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
