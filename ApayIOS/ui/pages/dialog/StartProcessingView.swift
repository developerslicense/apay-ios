//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct StartProcessingView: View {
    @StateObject var viewModel = StartProcessingViewModel()

    @Environment(\.dismiss) var dismiss

    @State var presentSheet: Bool = false
    @State var isError: Bool = false

   /* @State var savedCards: Array<BankCard> = [
//        BankCard(maskedPan: "111111....1111", typeIcon: "icAmericanExpress"), //todo добавить проверку на количество карт, чтоб  размер боттощита увеличивать на полную
        BankCard(maskedPan: "111111....2222", typeIcon: "icVisa"),
        BankCard(maskedPan: "111111....3333", typeIcon: "icMasterCard")
    ]*/
    @State var needShowProgressBar: Bool = true
    var actionClose: () -> Void
//        actionOnLoadingCompleted: () -> Unit = {},
    var backgroundColor: Color = ColorsSdk.bgBlock
    @State var isAuthenticated: Bool = false
    @State var isLoading: Bool = true
    @State var selectedCard: BankCard? = nil

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
//                        InitViewStartProcessingAPay()  //todo временно закоментировал

                        if (!viewModel.savedCards.isEmpty
//                                && isAuthenticated
                           ) {
                            InitViewStartProcessingCards( // todo внутри есть закоментированное
                                    savedCards: viewModel.savedCards,
                                    selectedCard: selectedCard
//                                    actionClose: actionClose
                            )
                        }

                        InitViewStartProcessingButtonNext(
                                savedCards: viewModel.savedCards,
                                actionClose: actionClose,
                                isAuthenticated: isAuthenticated,
                                selectedCard: selectedCard
                        )
                    }
                    Spacer()
                }
        ).onAppear {
                    Task {
                        await viewModel.fetchAppliances()
                    }
                }
    }

}

