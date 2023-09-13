//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI

// https://www.vadimbulavin.com/swiftui-popup-sheet-popover/

struct Popup<T: View>: ViewModifier {
    let popup: T
    let isPresented: Bool

    // 1.
    init(isPresented: Bool, @ViewBuilder content: () -> T) {
        self.isPresented = isPresented
        popup = content()
    }

    // 2.
    func body(content: Content) -> some View {
        content
                .overlay(popupContent())
    }

    // 3.
    @ViewBuilder private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                popup
                        .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}