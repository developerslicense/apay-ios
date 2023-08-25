//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct CoreEditText: View {

    @State var text: String
    @State var paySystemIcon: String = ""

    @State var isError: Bool
    @State var hasFocus: Bool

    var isDateExpiredMask: Bool
    var isCardNumberMask: Bool
    var isCvvMask: Bool
    var placeholder: String
    var regex: Regex<AnyRegexOutput>?
//        keyboardActions: KeyboardActions
//        keyboardOptions: KeyboardOptions
//        focusRequester: FocusRequester

    var actionOnTextChanged: (String) -> Void
    var actionClickInfo: (() -> Void)? = nil

    @State private var textBeforeChange: String = ""

    private var maskUtilsCardNumber: MaskUtils {
        let mu = MaskUtils()
        mu.pattern = isDateExpiredMask ? "AA/AA"
                : isCardNumberMask ? "AAAA AAAA AAAA AAAA"
                : "AAA"

        return mu
    }

    var body: some View {
        VStack {

            HStack {
                if (actionClickInfo != nil) {
                    Image(isError ? "icHintError" : "icHint")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .onTapGesture(perform: {
                                actionClickInfo!()
                            })
                }

                if isCardNumberMask && !text.isEmpty {
                    Image(paySystemIcon)
                            .resizable()
                            .frame(width: 24, height: 24)
                }

                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                                .foregroundColor(hasFocus ? ColorsSdk.colorBrandMain : ColorsSdk.textLight)
                                .frame(width: .infinity, alignment: .leading)
                                .textStyleRegular()
                    }

                    TextField("",
                            text: $text
//                            formatter: CoreEditText.df,
                            /* onEditingChanged: { (isBegin) in
                                if isBegin {
                                    print("Begins editing")
                                } else {
                                    print("Finishes editing")
                                }
                            },
                            onCommit: {
                                print("commit")
                            }*/

                    )
                            .onChange(
                                    of: text,
                                    perform: { newValue in
                                        if (isCardNumberMask) {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                                withAnimation {
                                                    self.paySystemIcon = getCardTypeFromNumber(input: newValue)
                                                }
                                            }
                                        }

                                        if (newValue.count > textBeforeChange.count) {
                                            text = maskUtilsCardNumber.format(
                                                    text: getNumberClearedWithMaxSymbol(
                                                            amount: newValue,
                                                            maxSize: 16
                                                    )
                                            )
                                        }
                                        textBeforeChange = text
                                        actionOnTextChanged(text)
                                    }
                            )
                            .disableAutocorrection(true)
                            .textStyleRegular()
                            .foregroundColor(ColorsSdk.transparent)
                            .frame(width: .infinity, alignment: .leading)
                }
                        .frame(minHeight: 24)


                if !text.isEmpty {
                    Image("icClose")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .onTapGesture(perform: {
                                text = ""
                                actionOnTextChanged("")
                            })
                }
            }
        }
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                                .stroke(ColorsSdk.gray5, lineWidth: 1)
                )
    }
}

internal func clearText(
        text: String,
        regex: Regex<AnyRegexOutput>
) -> String {
    var tempText = text
    tempText.replace(regex, with: "")

    return tempText
}


/*


    val onTextChanged: ((TextFieldValue) -> Unit) = {
        if (maskUtils != null
            && it.text.length > text.value.text.length
        ) {
            val result = if (regex != null)
                clearText(
                    text = it.text,
                    regex = regex
                ) else it.text

            text.value = TextFieldValue(
                text = maskUtils.format(result),
                selection = TextRange(maskUtils.getNextCursorPosition(it.selection.end) ?: 0)
            )

        } else {
            text.value = it
        }

        actionOnTextChanged.invoke(text.value.text)
    }

    TextField(
        value = text.value,
        onValueChange = onTextChanged,
        label = { Text(text = placeholder) },
        keyboardOptions = keyboardOptions,
        keyboardActions = keyboardActions,
        visualTransformation = visualTransformation ?: VisualTransformation.None,
        colors = TextFieldDefaults.outlinedTextFieldColors(
            backgroundColor = if (isError) ColorsSdk.stateBgError else ColorsSdk.bgBlock,
            textColor = if (isError) ColorsSdk.stateError else ColorsSdk.textMain,
            focusedLabelColor = if (isError) ColorsSdk.stateError else ColorsSdk.colorBrandMainMS.value,
            unfocusedLabelColor = if (isError) ColorsSdk.stateError else ColorsSdk.textLight,
            focusedBorderColor = ColorsSdk.transparent,
            cursorColor = ColorsSdk.colorBrandMainMS.value,
            unfocusedBorderColor = ColorsSdk.transparent,
        ),
        modifier = Modifier
            .fillMaxWidth()
            .onFocusChanged {
                hasFocus.value = it.hasFocus
            }
            .focusRequester(focusRequester),
        leadingIcon = if (actionClickInfo == null
            && paySystemIcon == null
       ) {
            null
        } else if(paySystemIcon != null) {{
            InitIconPaySystem(
                isError = isError,
                text = text.value.text,
                paySystemIcon = paySystemIcon
            )

        }} else {{
            InitIconInfo(
                isError = isError,
                actionClickInfo = { actionClickInfo?.invoke() }
            )
        }}
    )*/

