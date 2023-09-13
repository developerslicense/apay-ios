//
// Created by Mikhail Belikov on 16.08.2023.
//

import Foundation
import SwiftUI


extension View {

    func textStyleRegular(textColor: Color? = nil) -> some View {
        fontWithLineHeight(
//                font: .system(size: 14).weight(Font.Weight.regular),
                font: Font.custom("Montserrat-Regular", fixedSize: 14),
                lineHeight: 1.57, //22
                textColor: textColor
        )
    }

    func textStyleBodyRegular() -> some View {
        fontWithLineHeight(
//                font: .system(size: 16).weight(Font.Weight.regular),
                font: Font.custom("Montserrat-Regular", fixedSize: 16),
                lineHeight: 1.5 //24
        )
    }

    func textStyleCaption400() -> some View {
        fontWithLineHeight(
//                font: .system(size: 12).weight(Font.Weight.regular),
                font: Font.custom("Montserrat-Regular", fixedSize: 12),
                lineHeight: 1.5 //18
        )
    }

    func textStyleSubtitleBold() -> some View {
        fontWithLineHeight(
//                font: .system(size: 16).weight(Font.Weight.bold),
                font: Font.custom("Montserrat-Bold", fixedSize: 16),
                lineHeight: 1.5 //24
        )
    }

    func textStyleSemiBold() -> some View {
        fontWithLineHeight(
//                font: .system(size: 14).weight(Font.Weight.semibold),
                font: Font.custom("Montserrat-SemiBold", fixedSize: 14),
                lineHeight: 1.57 //22
        )
    }

    func textStyleH0() -> some View {
        fontWithLineHeight(
//                font: .system(size: 18).weight(Font.Weight.bold),
                font: Font.custom("Montserrat-Bold", fixedSize: 18),
                lineHeight: 1.6 // 24
        )
    }

    func textStyleH1() -> some View {
        fontWithLineHeight(
//                font: .system(size: 24).weight(Font.Weight.bold),
                font: Font.custom("Montserrat-Bold", fixedSize: 24),
                lineHeight: 1.6 // 22.5
        )
    }

    func textStyleH2() -> some View {
        fontWithLineHeight(
//                font: .system(size: 24).weight(Font.Weight.semibold),
                font: Font.custom("Montserrat-SemiBold", fixedSize: 24),
                lineHeight: 1.2 //24
        )
    }

    func textStyleH3() -> some View {
        fontWithLineHeight(
//                font: .system(size: 20).weight(Font.Weight.bold),
                font: Font.custom("Montserrat-Bold", fixedSize: 20),
                lineHeight: 1.5 // 30
        )
    }

    func textStyleNote() -> some View {
        fontWithLineHeight(
//                font: .system(size: 10).weight(Font.Weight.semibold),
                font: Font.custom("Montserrat-SemiBold", fixedSize: 10),
                lineHeight: 1.2 // 12
        )
    }

    func textStyleButton() -> some View {
        fontWithLineHeight(
                font: .system(size: 15).weight(Font.Weight.semibold),
//                font: Font.custom("Montserrat-Bold", fixedSize: 35),
                lineHeight: 1.2 // 24
        )
    }

    func textStyleButtonSmall() -> some View {
        fontWithLineHeight(
//                font: .system(size: 13).weight(Font.Weight.semibold),
                font: Font.custom("Montserrat-SemiBold", fixedSize: 13),
                lineHeight: 1.5  // 19.5
        )
    }

    func fontWithLineHeight(font: Font, lineHeight: CGFloat, textColor: Color? = nil) -> some View {
        ModifiedContent(content: self, modifier: FontWithLineHeight(font: font, lineHeight: lineHeight, textColor: textColor))
    }

    public func loadCustomFonts() -> some View {
        AirbaPayFonts.registerCustomFonts()
        return self
    }
}

public enum AirbaPayFonts {
    public static func registerCustomFonts() {
        for font in ["Montserrat-SemiBold.ttf", "Montserrat-Bold.ttf", "Montserrat-Regular.ttf"] {
            guard let url = Bundle.designSystem.url(forResource: font, withExtension: nil) else { return }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
}

struct FontWithLineHeight: ViewModifier {
    let font: Font
    let lineHeight: CGFloat
    let textColor: Color?

    func body(content: Content) -> some View {
        content
                .foregroundColor(textColor ?? ColorsSdk.textMain)
                .font(font)
                .lineSpacing(lineHeight)
    }
}
