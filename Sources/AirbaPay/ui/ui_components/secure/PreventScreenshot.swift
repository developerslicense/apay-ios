//
//  PreventScreenshot.swift
//
//  Created by Mikhail Belikov on 26.04.2024.
//

import Foundation
import SwiftUI

public struct PreventScreenshot: ViewModifier {
    public let isProtected: Bool

    public func body(content: Content) -> some View {
        SecureView(preventScreenCapture: isProtected) {
            content
        }
    }
}

public extension View {
    func screenshotProtected(isProtected: Bool) -> some View {
        modifier(PreventScreenshot(isProtected: isProtected))
    }
}
