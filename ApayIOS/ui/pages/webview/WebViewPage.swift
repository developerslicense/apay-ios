//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI
import WebKit

struct WebViewPage: View {

    @State var showDialogExit: Bool = false
    @StateObject private var model = SwiftUIWebViewModel()

    var body: some View {
        ZStack {
            ColorsSdk.bgMain
            VStack {
                Image("icArrowBack")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.black)
                        .padding(.top, 12)
                        .padding(.leading, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture(perform: {
                            showDialogExit = true
                        })

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

    @Published var faqUrl: String? = DataHolder.redirectUrl

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
    typealias UIViewType = WKWebView

    let webView: WKWebView

    func makeUIView(context: Context) -> WKWebView {
        webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
