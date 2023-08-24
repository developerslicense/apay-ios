//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct CoreEditText: View {

    @State var text: String
    @State var paySystemIcon: String? = nil

    @State var isError: Bool
    @State var hasFocus: Bool

    var isDateExpiredMask: Bool
    var placeholder: String
    var mask: String?
    var regex: Regex<AnyRegexOutput>?
//        keyboardActions: KeyboardActions
//        keyboardOptions: KeyboardOptions
//        focusRequester: FocusRequester

    var actionOnTextChanged: (String) -> Void
    var actionClickInfo: (() -> Void)? = nil

//        visualTransformation: VisualTransformation? = nil


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

                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                                .foregroundColor(hasFocus ? ColorsSdk.colorBrandMain : ColorsSdk.textLight)
                                .frame(width: .infinity, alignment: .leading)
                                .textStyleRegular()
                    }

                    TextField(
                            "",
                            text: $text,
                            onCommit: {
                                actionOnTextChanged(text)
                            }
                    )
                            .textStyleRegular()
                            .frame(width: .infinity, alignment: .leading)
                }.frame(minHeight: 24)

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

/*
    val maskUtils: MaskUtils? = if (mask == null) null else MaskUtils(mask, isDateExpiredMask)

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


/*
private fun clearText(
    text: String,
    regex: Regex?
) = try {
    val temp = regex?.let { regexForClear ->
        text.replace(
            regex = regexForClear,
            replacement = ""
        )
    } ?: text

    temp

} catch (e: Exception) {
//    e.printStackTrace()
    ""
}



@Composable
private fun InitIconPaySystem(
    isError: Boolean,
    text: String,
    paySystemIcon: Int?
) {
    if (
        text.isNotBlank()
        && paySystemIcon != null
    ) {
        InitActionIcon(
            action = null,
            iconSrc = paySystemIcon,
            modifier = Modifier.size(40.dp),
            _outlinedButtonColor = if (isError) ColorsSdk.stateBgError else ColorsSdk.bgBlock
        )
    }
}*/