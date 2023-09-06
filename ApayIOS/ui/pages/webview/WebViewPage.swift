//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI
import WebKit

struct WebViewPage: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    @StateObject private var viewModel = SwiftUIWebViewModel()
    @State var showDialogExit: Bool = false

    init(
            @ObservedObject navigateCoordinator: AirbaPayCoordinator,
            redirectUrl: String?
    ) {
        self.navigateCoordinator = navigateCoordinator
        viewModel.redirectUrl = redirectUrl
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

                SwiftUIWebView(webView: viewModel.webView)
                        .onAppear {
                            viewModel.loadUrl()
                        }
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

private final class SwiftUIWebViewModel: ObservableObject {

    @Published var redirectUrl: String?

    let webView: WKWebView

    init() {
        webView = WKWebView(frame: .zero)
    }

    func loadUrl() {
        guard let url = URL(string: redirectUrl ?? "") else {
            return
        }
        webView.load(URLRequest(url: url))
    }
}

private struct SwiftUIWebView: UIViewRepresentable {
    let webView: WKWebView

    func makeUIView(context: Context) -> WKWebView {
        webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        print("aaaaaaa updateUIView")
        print(uiView.url)
    }
}
