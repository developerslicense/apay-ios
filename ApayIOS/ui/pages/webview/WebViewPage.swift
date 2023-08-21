//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI
import WebKit

internal struct WebViewPage: View {

//    @Environment(\.presentationMode) var presentationMode
    @StateObject private var model = SwiftUIWebViewModel()

    var body: some View {
        ZStack {
            ColorsSdk.bgMain
            VStack {
                Image("icArrowBack")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black)
                        .padding(.top, 12)
                        .padding(.leading, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture(perform: {

                        })

                SwiftUIWebView(webView: model.webView)
                        .onAppear {
                            model.loadUrl()
                        }
            }
        }
    }
}

private final class SwiftUIWebViewModel: ObservableObject {

    @Published var faqUrl: String? = DataHolder.redirectUrl

    let webView: WKWebView

    init() {
        webView = WKWebView(frame: .zero)
    }

    func loadUrl() {
        guard let url = URL(string: faqUrl ?? "https://google.com") else {
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