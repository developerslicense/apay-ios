//
// Created by Mikhail Belikov on 18.08.2023.
//

import Foundation
import SwiftUI

struct ViewButton: View {
    var title: String
    var isMainBrand: Bool = true
    var isRedText: Bool = false
    var actionClick: () -> Void
    var isVisible: Bool = true

    var body: some View {
        let button = BaseButtonStyle(
                textColor: initButtonTextColor(isMainBrand: isMainBrand),
                backgroundColor: initButtonBackground(isMainBrand: isMainBrand)
        )

        if isVisible {
            Button(
                    action: {
                        actionClick()
                    },
                    label: {
                        Text(title).frame(maxWidth: .infinity)
                    }
            )
                    .buttonStyle(button)
        }
    }

    private func initButtonBackground(isMainBrand: Bool) -> Color {
        if isMainBrand {
            return ColorsSdk.colorBrandMain
        } else {
            return ColorsSdk.gray5
        }
    }

    private func initButtonTextColor(isMainBrand: Bool) -> Color {
        if isRedText {
            return ColorsSdk.stateError
        } else if isMainBrand {
            return ColorsSdk.colorBrandInversion
        } else {
            return ColorsSdk.colorBrandMain
        }
    }
}

struct BaseButtonStyle: ButtonStyle {
    var textColor: Color
    var backgroundColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
                .padding()
                .background(backgroundColor)
                .foregroundColor(textColor)
                .cornerRadius(8)
                .textStyleSubtitleBold()
    }
}

