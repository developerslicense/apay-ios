//
// Created by Mikhail Belikov on 28.08.2023.
//

import Foundation
import SwiftUI

// https://suragch.medium.com/getting-and-setting-the-cursor-position-in-swift-68da99bcef39
struct CoreEditText: View {

    @State var text: String = ""
    @State var value: String = ""
    @State var paySystemIcon: String = ""

    var isError: Bool
    var isDateExpiredMask: Bool
    var isCardNumberMask: Bool
    var isCvvMask: Bool
    var placeholder: String
//    var regex: Regex<AnyRegexOutput>? // доступен с 16-го айоса
    var keyboardType: UIKeyboardType

    var actionOnTextChanged: (String) -> Void
    var actionClickInfo: (() -> Void)? = nil

    @State private var textBeforeChange: String = ""
    @State private var cursorPositionForShow: Int = 5

    private var maskUtils: MaskUtils { //todo если понадобится без маски какое-то поле, нужно будет доработать
        let mu = MaskUtils()
        mu.pattern = isDateExpiredMask ? "AA/AA"
                : isCardNumberMask ? "AAAA AAAA AAAA AAAA"
                : "AAA"

        return mu
    }

    var body: some View {
        HStack {
            if (actionClickInfo != nil) {
                Image(isError ? "icHintError" : "icHint", bundle: DataHolder.moduleBundle)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .onTapGesture(perform: {
                            actionClickInfo!()
                        })
            }

            if isCardNumberMask
                       && !text.isEmpty
                       && !paySystemIcon.isEmpty {
                Image(paySystemIcon, bundle: DataHolder.moduleBundle)
                        .resizable()
                        .frame(width: 24, height: 24)
            }

            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                            .foregroundColor(ColorsSdk.textLight)
                            .frame(width: .infinity, alignment: .leading)
                            .textStyleRegular()
                }

                if (isCvvMask) {
                    let textField = SecureField("", text: $text)

                    textField
                            .onChange(
                                    of: text,
                                    perform: { newValue in
                                        onPerformed(newValue: newValue)
                                    }
                            )
                            .keyboardType(keyboardType)
                            .disableAutocorrection(true)
                            .textStyleRegular(textColor: isError ? ColorsSdk.stateError : ColorsSdk.textMain)
                            .foregroundColor(ColorsSdk.transparent)
                            .frame(width: .infinity, alignment: .leading)
                            .accentColor(ColorsSdk.colorBrandMain)

                } else {
                    let textField = TextField("", text: $text)

                    textField
                            .onChange(
                                    of: text,
                                    perform: { newValue in
                                        onPerformed(newValue: newValue)
                                    }
                            )
                            .keyboardType(keyboardType)
                            .disableAutocorrection(true)
                            .textStyleRegular(textColor: isError ? ColorsSdk.stateError : ColorsSdk.textMain)
                            .foregroundColor(ColorsSdk.transparent)
                            .frame(width: .infinity, alignment: .leading)
                            .accentColor(ColorsSdk.colorBrandMain)
                }
            }
                    .frame(minHeight: 24)


            if !text.isEmpty {
                Image("icClose", bundle: DataHolder.moduleBundle)
                        .resizable()
                        .frame(width: 14, height: 14)
                        .onTapGesture(perform: {
                            text = ""
                            actionOnTextChanged("")
                        })
            }
        }
                .padding()
                .background(isError ? ColorsSdk.stateBgError : ColorsSdk.bgBlock)
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                                .stroke(isError ? ColorsSdk.stateError : ColorsSdk.gray5, lineWidth: 1)
                )
    }

    private func onPerformed(newValue: String) {
        if (isCardNumberMask) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                withAnimation {
                    self.paySystemIcon = getCardTypeFromNumber(input: newValue)
                }
            }
        }

        if (newValue.count > textBeforeChange.count) {
            text = maskUtils.format(
                    text: getNumberClearedWithMaxSymbol(
                            amount: newValue,
                            maxSize: 16
                    )
            )
        }

        textBeforeChange = text
        actionOnTextChanged(text)
    }
}
