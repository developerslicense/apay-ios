//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }

    func padding(sides: [SideHorizontal], value: CGFloat = 8) -> some View {
        HStack(spacing: 0) {
            if sides.contains(.left) {
                Spacer().frame(width: value)
            }
            self
            if sides.contains(.right) {
                Spacer().frame(width: value)
            }
        }
    }

    func padding(sides: [SideVertical], value: CGFloat = 8) -> some View {
        HStack(spacing: 0) {
            if sides.contains(.top) {
                Spacer().frame(height: value)
            }
            self
            if sides.contains(.bottom) {
                Spacer().frame(height: value)
            }
        }
    }
}

internal enum SideHorizontal: Equatable, Hashable {
    case left
    case right
}

internal enum SideVertical: Equatable, Hashable {
    case top
    case bottom
}

internal struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
