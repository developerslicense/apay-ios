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
    @ObservedObject var viewModel: ExternalApplePayViewModel = ExternalApplePayViewModel()
    private var isLoading: (Bool) -> Void


    public init(
            @ObservedObject navigateCoordinator: AirbaPayCoordinator,
            externalApplePayRedirectToContainer: (() -> Void)? = nil,
            isLoading: @escaping (Bool) -> Void
    ) {
        self.navigateCoordinator = navigateCoordinator
        DataHolder.externalApplePayRedirectToContainer = externalApplePayRedirectToContainer
        self.isLoading = isLoading
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

            if(navigationAction.navigationType == .other) {
                decisionHandler(.allow)

                let url = navigationAction.request.url?.absoluteString ?? ""

                if (url).contains("acquiring-api") == true {

                    DataHolder.externalApplePayRedirectToContainer?()
                    navigateCoordinator.openAcquiring(redirectUrl: url)
                }
                else if (url).contains("success") == true {

                    DataHolder.externalApplePayRedirectToContainer?()
                    navigateCoordinator.openSuccess()
                }
                else if (url).contains("failure") == true ||  (url).contains("error") == true {

                    DataHolder.externalApplePayRedirectToContainer?()
                    navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
                }

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

