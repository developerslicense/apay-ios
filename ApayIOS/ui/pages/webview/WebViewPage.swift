//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI
import WebKit
import Combine

struct WebViewPage: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    @State var showDialogExit: Bool = false
    var redirectUrl: String?

    init(
            @ObservedObject navigateCoordinator: AirbaPayCoordinator,
            redirectUrl: String?
    ) {
        self.navigateCoordinator = navigateCoordinator
        self.redirectUrl = redirectUrl
    }

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgMain

            VStack {
                ViewToolbar(
                        title: "",
                        actionShowDialogExit: { showDialogExit = true }
                )
                        .frame(maxWidth: .infinity, alignment: .leading)

                SwiftUIWebView(
                        url: redirectUrl,
                        navigateCoordinator: navigateCoordinator
                )
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
        self.webView.navigationDelegate = context.coordinator
        if let url = URL(string: viewModel.link) {
            self.webView.load(URLRequest(url: url))
        }
        return self.webView
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

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> ()) {
            print("sssssssssss")
            print(navigationAction.request.url)

            if(navigationAction.navigationType == .other) {
                if let redirectedUrl = navigationAction.request.url {


                    if redirectedUrl.absoluteURL.path.contains("status=auth") ||
                            redirectedUrl.absoluteURL.path.contains("status=success") {

                        navigateCoordinator.openSuccess()

                    } else if redirectedUrl.absoluteURL.path.contains("status=error") {
/*val splitted = url.split(Regex("&"))
                    val result = splitted.first { element -> element.contains("errorCode") }
                    val resultSplitted = result.split(Regex("="))

                    val code = resultSplitted[1]
                        .replace("errorMsg", "") //todo временный костыль удаления "errorMsg" на период, пока не будет исправлено на бэке
                        .toInt()

                    openErrorPageWithCondition(
                        errorCode = code,
                        navController = navController!!
                    )*/
                        navigateCoordinator.openErrorPageWithCondition(errorCode: 1) //todo

                    } else {
//                        webView.load(URLRequest(url: redirectedUrl))
                        decisionHandler(.allow)
                        return
                    }
                }

                decisionHandler(.cancel)
                return
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

    init (link: String) {
        self.link = link
    }
}
