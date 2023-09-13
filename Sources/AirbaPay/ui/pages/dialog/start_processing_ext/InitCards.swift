//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import SwiftUI

struct InitViewStartProcessingCards: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    var savedCards: Array<BankCard>
    @State var selectedCard: BankCard?
    @State var selected: Int = 0

    var body: some View {
        VStack {
//            Text(orPayWithCard()) // todo временно закоментировал
//                    .foregroundColor(ColorsSdk.textLight)
//                    .textStyleRegular()
//                    .padding(.top, 32)

            LazyVStack {
                ForEach(0...savedCards.count - 1, id: \.self) { index in
                    let card = savedCards[index]
                    InitCard(
                            card: card,
                            isSelected: selected == index,
                            isFirst: index == 0,
                            clickOnCard: {
                                selected = index
                                selectedCard = card
                            }
                    )
                }
            }
                    .padding(.horizontal, 16)

            InitViewStartProcessingPayWithNewCard(
                    actionClick: {
                        navigateCoordinator.openHome()
                    }
            )
                    .padding(.top, 32)
        }
    }
}

struct InitCard: View {
    @State var card: BankCard
    var isSelected: Bool
    var isFirst: Bool
    var clickOnCard: () -> Void

    var body: some View {
        VStack {
            if (!isFirst) {
                Divider()
            }

            HStack {
                Image(card.typeIcon ?? "", bundle: DataHolder.moduleBundle)

                Text(card.getMaskedPanCleared())
                        .textStyleSemiBold()
                        .padding(.leading, 16)

                Spacer().frame(height: 56)

                ZStack {
                    if (isSelected) {
                        Circle()
                                .fill(ColorsSdk.colorBrandMain)
                                .frame(width: 20, height: 20)
                        Circle()
                                .fill(ColorsSdk.gray0)
                                .frame(width: 8, height: 8)


                    } else {
                        Circle()
                                .fill(ColorsSdk.gray15)
                                .frame(width: 20, height: 20)
                        Circle()
                                .fill(ColorsSdk.bgBlock)
                                .frame(width: 18, height: 18)

                    }
                }
            }
                    .frame(height: 56)

        }
                .contentShape(Rectangle())
                .onTapGesture(perform: { clickOnCard() })

    }
}
