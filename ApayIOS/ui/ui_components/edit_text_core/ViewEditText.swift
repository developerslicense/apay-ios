//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct ViewEditText: View {
    @State var text: String
    @State var errorTitle: String?
    @State var hasFocus: Bool

    var placeholder: String
    var maskUtils: MaskUtils?
    var regex: Regex<AnyRegexOutput>? = nil
    var isDateExpiredMask: Bool
    var isCardNumber: Bool
//        focusRequester: FocusRequester
//        modifierRoot: Modifier: Modifier
//        modifierChild: Modifier: Modifier
//        keyboardActions: KeyboardActions
//        keyboardOptions: KeyboardOptions: KeyboardOptions.Default.copy(
//        capitalization: KeyboardCapitalization.None
//        autoCorrect: false
//        keyboardType: KeyboardType.Text
//        imeAction: ImeAction.Next
//)
//        visualTransformation: VisualTransformation?: null
    var actionOnTextChanged: (String) -> Void
    var actionClickInfo: (() -> Void)?

    var body: some View {

        VStack {
            CoreEditText(
                    text: text,
                    isError: errorTitle != nil,
                    hasFocus: hasFocus,
                    isDateExpiredMask: isDateExpiredMask,
                    isCardNumber: isCardNumber,
                    placeholder: placeholder,
                    regex: regex,
                    actionOnTextChanged: actionOnTextChanged,
                    actionClickInfo: actionClickInfo,
                    maskUtils: maskUtils
            )
        }
    }
}

/* Column(
        modifier = modifierRoot
    ) {

        Card(
            shape = RoundedCornerShape(8.dp),
            elevation = 0.dp,
            border = BorderStroke(
                0.1.dp,
                if (errorTitle.value != null) ColorsSdk.stateError else ColorsSdk.gray20
            ),
            modifier = modifierChild
                .wrapContentHeight()
                .heightIn(min = 48.dp),
            onClick = {}
        ) {
            ConstraintLayout {
                val (clearIconRef) = createRefs()

                CoreEditText(
                    isError = errorTitle.value != null,
                    mask = mask,
                    regex = regex,
                    placeholder = placeholder,
                    keyboardActions = keyboardActions,
                    keyboardOptions = keyboardOptions,
                    hasFocus = hasFocus,
                    text = text,
                    focusRequester = focusRequester,
                    actionOnTextChanged = actionOnTextChanged,
                    visualTransformation = visualTransformation,
                    isDateExpiredMask = isDateExpiredMask,
                    actionClickInfo = actionClickInfo,
                    paySystemIcon = paySystemIcon.value
                )

                InitIconClear(
                    clearIconRef = clearIconRef,
                    hasFocus = hasFocus.value,
                    text = text.value.text,
                    isError = errorTitle.value != null,
                    actionClickClear = {
                        text.value = TextFieldValue(
                            text = "",
                            selection = TextRange(0)
                        )
                        paySystemIcon.value = null
                    }
                )
            }
        }

        if (errorTitle.value != null) {
            Row {
                Icon(
                    painter = painterResource(R.drawable.alarm),
                    contentDescription = "alarm",
                    tint = ColorsSdk.stateError,
                    modifier = Modifier.padding(vertical = 4.dp)
                )
                Text(
                    style = LocalFonts.current.caption400,
                    text = errorTitle.value!!,
                    color = ColorsSdk.stateError,
                    modifier = Modifier.padding(vertical = 4.dp)
                )
            }

        }
    }*/


/*@Composable
private fun ConstraintLayoutScope.InitIconClear(
    isError: Boolean,
    text: String,
    hasFocus: Boolean,
    actionClickClear: () -> Unit,
    clearIconRef: ConstrainedLayoutReference
) {
    if (
        text.isNotBlank()
        && hasFocus
    ) {
        InitActionIcon(
            action = actionClickClear,
            iconSrc = R.drawable.ic_close,
            modifier = Modifier
                .size(40.dp)
                .constrainAs(clearIconRef) {
                    end.linkTo(parent.end)
                    top.linkTo(parent.top)
                    bottom.linkTo(parent.bottom)
                },
            _outlinedButtonColor = if (isError) ColorsSdk.stateBgError else ColorsSdk.bgBlock
        )
    }
}*/