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
//            RepeatPage()
//            ErrorSomethingWrongPage()
//            ErrorFinalPage()
//            ErrorWithInstructionPage()
//            ErrorPage(errorCode: ErrorsCode(code: 5009))
//            WebViewPage()
            HomePage()
        }
    }
}
