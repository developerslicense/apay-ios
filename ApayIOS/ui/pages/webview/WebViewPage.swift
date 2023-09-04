//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI
import WebKit

struct WebViewPage: View {

    var faqUrl: String?
    @State var showDialogExit: Bool = false
    @StateObject private var model = SwiftUIWebViewModel()
    @EnvironmentObject var router: NavigateUtils.Router

    init() {
        model.faqUrl = faqUrl
    }

    var body: some View {
        ZStack {
            ColorsSdk.bgMain
            VStack {
                ViewToolbar(
                        title: "",
                        actionShowDialogExit: { showDialogExit = true }
                )
                        .frame(maxWidth: .infinity, alignment: .leading)

                SwiftUIWebView(webView: model.webView)
                        .onAppear {
                            model.loadUrl()
                        }
            }
        }
                .modifier(
                        Popup(
                                isPresented: showDialogExit,
                                content: {
                                    DialogExit(onDismissRequest: { showDialogExit = false })
                                })
                )
                .onTapGesture(perform: { showDialogExit = false })
    }
}

private final class SwiftUIWebViewModel: ObservableObject {

    @Published var faqUrl: String?

    let webView: WKWebView

    init() {
        webView = WKWebView(frame: .zero)
    }

    func loadUrl() {
        guard let url = URL(string: faqUrl ?? "") else {
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
    }
}
