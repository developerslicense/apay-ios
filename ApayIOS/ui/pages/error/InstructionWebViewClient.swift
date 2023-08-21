//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI
import WebKit

internal struct InstructionWebViewClient: View {

    @StateObject private var model = SwiftUIWebViewModel()

    var body: some View {
        SwiftUIWebView(webView: model.webView)
                .onAppear {
                    model.loadUrl()
                }
    }
}

private final class SwiftUIWebViewModel: ObservableObject {

    @Published var faqUrl: String

    let webView: WKWebView
    init() {
        if (DataHolder.bankName == BanksName.kaspibank) {
            if (DataHolder.currentLang == AirbaPaySdk.Lang.KZ()) {
                faqUrl = "https://static-data.object.pscloud.io/pay-manuals/Kaspi_kaz.mp4"
            }
            else {
                faqUrl = "https://static-data.object.pscloud.io/pay-manuals/Kaspi_rus.mp4"
            }
        } else {
            if(DataHolder.currentLang == AirbaPaySdk.Lang.KZ()) {
                faqUrl = "https://static-data.object.pscloud.io/pay-manuals/Halyk_kaz.mp4"
            }
            else {
                faqUrl = "https://static-data.object.pscloud.io/pay-manuals/Halyk_rus.mp4"
            }
        }

        webView = WKWebView(frame: .zero)
    }

    func loadUrl() {
        guard let url = URL(string: faqUrl) else {
            return
        }
        webView.load(URLRequest(url: url))
    }
}

private struct SwiftUIWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    let webView: WKWebView

    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}