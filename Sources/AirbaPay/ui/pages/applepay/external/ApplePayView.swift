//
//  ApplePayView.swift
//
//  Created by Mikhail Belikov on 26.03.2024.
//


import Foundation
import SwiftUI
import WebKit
import Combine
import UIKit

public struct ApplePayView: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    @State var showDialogExit: Bool = false
    @StateObject var viewModel = ExternalApplePayViewModel()
    private var isLoading: (Bool) -> Void


    public init(
            redirectFromStoryboardToSwiftUi: (() -> Void)? = nil,
            @ObservedObject navigateCoordinator: AirbaPayCoordinator,
            isLoading: @escaping (Bool) -> Void
    ) {
        self.navigateCoordinator = navigateCoordinator
        self.isLoading = isLoading
        DataHolder.redirectFromStoryboardToSwiftUi = redirectFromStoryboardToSwiftUi
    }

    public var body: some View {

        VStack {
            if viewModel.applePayUrl != nil {

                ZStack {
                    ColorsSdk.gray30
                    ColorsSdk.bgMain

                    SwiftUIWebView(
                            url: viewModel.applePayUrl,
                            navigateCoordinator: navigateCoordinator
                    )
                }
            }
        }
                .onAppear {
                    viewModel.fetchData(
                            navigateCoordinator: navigateCoordinator,
                            isLoading: isLoading
                    )
                }
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


        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> ()) {

            if (navigationAction.navigationType == .other) {
                decisionHandler(.allow)

                let url = navigationAction.request.url?.absoluteString ?? ""

                if (url).contains("acquiring-api") == true {
                    print("aaaaaaaaa acquiring-api")
                    DataHolder.externalApplePayRedirect = {
                        self.navigateCoordinator.openAcquiring(redirectUrl: url)
                    }
                    redirectTo()
                } else if (url).contains("success") == true {
                    print("aaaaaaaaa success")

                    DataHolder.externalApplePayRedirect = {
                        self.navigateCoordinator.openSuccess()
                    }
                    redirectTo()

                } else if (url).contains("failure") == true || (url).contains("error") == true {
                    print("aaaaaaaaa failure")

                    DataHolder.externalApplePayRedirect = {
                        self.navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
                    }
                    redirectTo()
                }

                return

            }

            decisionHandler(.allow)
        }

        func redirectTo() {
            if DataHolder.redirectFromStoryboardToSwiftUi != nil {
                print("aaaaaaaaa redirectFromStoryboardToSwiftUi")
                DataHolder.redirectFromStoryboardToSwiftUi!()
            } else {
                print("aaaaaaaaa externalApplePayRedirect")
                DataHolder.externalApplePayRedirect!()
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

