//
// Created by Mikhail Belikov on 16.08.2023.
//

import Foundation
import SwiftUI


internal extension View {

    func textStyleRegular() -> some View {
        fontWithLineHeight(
                font: .system(size: 14).weight(Font.Weight.regular),
//                font: Font.custom("Montserrat-Regular", fixedSize: 14),
                lineHeight: 22 //1.57
        )
    }

    func textStyleBodyRegular() -> some View {
        fontWithLineHeight(
                font: .system(size: 16).weight(Font.Weight.regular),
//                font: Font.custom("Montserrat-Regular", fixedSize: 16),
                lineHeight: 24 //1.5
        )
    }

    func textStyleCaption400() -> some View {
        fontWithLineHeight(
                font: .system(size: 12).weight(Font.Weight.regular),
//                font: Font.custom("Montserrat-Regular", fixedSize: 12),
                lineHeight: 18 //1.5
        )
    }

    func textStyleSubtitleBold() -> some View {
        fontWithLineHeight(
                font: .system(size: 16).weight(Font.Weight.bold),
//                font: Font.custom("Montserrat-Bold", fixedSize: 16),
                lineHeight: 24 //1.5
        )
    }

    func textStyleSemiBold() -> some View {
        fontWithLineHeight(
                font: .system(size: 14).weight(Font.Weight.semibold),
//                font: Font.custom("Montserrat-SemiBold", fixedSize: 14),
                lineHeight: 22 //1.57
        )
    }

    func textStyleH0() -> some View {
        fontWithLineHeight(
                font: .system(size: 18).weight(Font.Weight.bold),
//                font: Font.custom("Montserrat-Bold", fixedSize: 18),
                lineHeight: 24 //1.6
        )
    }

    func textStyleH1() -> some View {
        fontWithLineHeight(
                font: .system(size: 24).weight(Font.Weight.bold),
//                font: Font.custom("Montserrat-Bold", fixedSize: 24),
                lineHeight: 22.5 //1.6
        )
    }

    func textStyleH2() -> some View {
        fontWithLineHeight(
                font: .system(size: 24).weight(Font.Weight.semibold),
//                font: Font.custom("Montserrat-SemiBold", fixedSize: 24),
                lineHeight: 24 //1.2
        )
    }

    func textStyleH3() -> some View {
        fontWithLineHeight(
                font: .system(size: 20).weight(Font.Weight.bold),
//                font: Font.custom("Montserrat-Bold", fixedSize: 20),
                lineHeight: 30 //1.5
        )
    }

    func textStyleNote() -> some View {
        fontWithLineHeight(
                font: .system(size: 10).weight(Font.Weight.semibold),
//                font: Font.custom("Montserrat-SemiBold", fixedSize: 10),
                lineHeight: 12 //1.2
        )
    }

    func textStyleButton() -> some View {
        fontWithLineHeight(
                font: .system(size: 15).weight(Font.Weight.semibold),
//                font: Font.custom("Montserrat-SemiBold", fixedSize: 15),
                lineHeight: 24 //1.2
        )
    }

    func textStyleButtonSmall() -> some View {
        fontWithLineHeight(
                font: .system(size: 13).weight(Font.Weight.semibold),
//                font: Font.custom("Montserrat-SemiBold", fixedSize: 13),
                lineHeight: 19.5 //1.5
        )
    }

    func fontWithLineHeight(font: Font, lineHeight: CGFloat) -> some View {
        ModifiedContent(content: self, modifier: FontWithLineHeight(font: font, lineHeight: lineHeight))
    }
}

internal struct FontWithLineHeight: ViewModifier {
    let font: Font
    let lineHeight: CGFloat

    func body(content: Content) -> some View {
        content
                .foregroundStyle(ColorsSdk.textMain)
                .font(font)
                .lineSpacing(lineHeight)
    }
}
