//
//  ApayIOSApp.swift
//  ApayIOS
//
//  Created by Mikhail Belikov on 14.08.2023.
//

import SwiftUI

@main
struct ApayIOSApp: App {
    init() {
        testInitOnCreate()
        testInitProcessing()
    }

    var body: some Scene {

        WindowGroup {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    NavigateUtils().view()
                }
            } else {
                NavigationView {
                    NavigateUtils().view()
                }
            }

//            NavigateUtils().view()
//            RepeatPage()
//            ErrorSomethingWrongPage()
//            ErrorFinalPage()
//            ErrorWithInstructionPage()
//            ErrorPage(errorCode: ErrorsCode(code: 5009))
//            WebViewPage()
//            HomePage()
//            TestPage()
        }
    }
}
