//
//  LoggerHelper.swift
//
//  Created by Mikhail Belikov on 28.03.2024.
//

import Foundation

class LoggerHelper {

    private static var previousPages: [String] = []
    private static var pageName: String = ""

    static func getPageName() -> String {
        return pageName
    }

    static func nextPage(pageName: String) {
        previousPages.append(self.pageName)
        self.pageName = pageName
    }

    static func onBackPressed() {
        self.pageName = previousPages.last ?? ""
        if !previousPages.isEmpty {
            previousPages.removeLast()
        }
    }

    static func clear() {
        previousPages = []
        pageName = ""
    }
}

