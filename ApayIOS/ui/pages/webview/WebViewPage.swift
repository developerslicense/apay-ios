//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI
import WebKit

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

                SwiftUIWebView(url: redirectUrl)
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
    let webView: WKWebView

    init(url: String?) {
        webView = WKWebView(frame: .zero)
        webView.load(URLRequest(url: URL(string: url ?? "https://")!))
    }

    func makeUIView(context: Context) -> WKWebView {
        webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {

    }

}
