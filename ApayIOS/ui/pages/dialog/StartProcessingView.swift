//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct StartProcessingView: View {
    @Environment(\.dismiss) var dismiss

    @State var presentSheet: Bool = false
    @State var isError: Bool = false

//        needShowProgressBar: Boolean = true,
//        actionClose: () -> Unit,
//        actionOnLoadingCompleted: () -> Unit = {},
//isBottomSheetType: Boolean = true,
//backgroundColor: Color = ColorsSdk.bgBlock,
//isAuthenticated: MutableState<Boolean>

    /*    val purchaseAmount = DataHolder.purchaseAmountFormatted.collectAsState()

val size = remember { mutableStateOf(IntSize.Zero) }
val isLoading  = remember { mutableStateOf(true) }
val selectedCard = remember { mutableStateOf<BankCard?>(null) }

val savedCards = remember {
    mutableStateOf<List<BankCard>>(emptyList())
}*/

    var body: some View {
        ColorsSdk.bgBlock.overlay(
                VStack {
                    InitHeader(
                            title: paymentByCard(),
                            actionClose: {
                                dismiss()
                            }
                    )

                    if (isError) {
                        InitErrorState()

                    } else {
                        InitViewStartProcessingAmount()
//                        InitViewStartProcessingAPay()

                    }
                    Spacer()
                }
        )
    }

}

internal struct InitErrorState: View {
    var body: some View {
        VStack {
            Image("icSomethingWrong")
                    .padding(.top, 24)
                    .padding(.bottom, 24)

            Text(somethingWentWrong())
                    .textStyleH3()
                    .frame(width: .infinity)
                    .frame(alignment: .center)
                    .padding(.bottom, 20)


        }
                .frame(width: .infinity, alignment: .center)
    }
}
