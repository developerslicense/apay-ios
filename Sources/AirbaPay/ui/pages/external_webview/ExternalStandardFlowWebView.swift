//
//  ExternalStandardFlowWebView.swift
//  AirbaPaySdk
//
//  Created by Mikhail Belikov on 05.06.2024.
//

import Foundation
import SwiftUI
import WebKit
import Combine

struct ExternalStandardFlowWebView: View {
    var navigateCoordinator: AirbaPayCoordinator
    var redirectUrl: String?

    init(
            navigateCoordinator: AirbaPayCoordinator,
            redirectUrl: String?
    ) {
        self.navigateCoordinator = navigateCoordinator
        self.redirectUrl = redirectUrl
    }

    var body: some View {
        ZStack {
            ColorsSdk.bgBlock

            VStack {

                SwiftUIWebView(
                        url: redirectUrl,
                        navigateCoordinator: navigateCoordinator
                )
            }
        }
    }
}

private struct SwiftUIWebView: UIViewRepresentable {
    var navigateCoordinator: AirbaPayCoordinator
    @ObservedObject var viewModel: WebViewModel
    @State var showDialogExit: Bool = false
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
        var navigateCoordinator: AirbaPayCoordinator
        private var viewModel: WebViewModel

        init(
                navigateCoordinator: AirbaPayCoordinator,
                viewModel: WebViewModel
        ) {
            self.navigateCoordinator = navigateCoordinator
            self.viewModel = viewModel
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> ()) {

            let shouldOverrideUrlLoading = AirbaPaySdk.ShouldOverrideUrlLoading(
                    isCallbackSuccess: (navigationAction.request.url?.absoluteString.contains(DataHolder.successBackUrl) == true),
                    isCallbackBackToApp: (navigationAction.request.url?.absoluteString.contains(DataHolder.failureBackUrl) == true),
                    navAction: navigationAction,
                    decisionHandler: decisionHandler,
                    navController: (navigateCoordinator.navigation ?? UINavigationController())
            )
            DataHolder.shouldOverrideUrlLoading?(shouldOverrideUrlLoading)
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


 
