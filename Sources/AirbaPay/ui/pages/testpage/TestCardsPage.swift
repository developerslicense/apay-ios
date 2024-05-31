//
//  TestCards.swift
//  AirbaPaySdk
//
//  Created by Mikhail Belikov on 16.05.2024.
//


import Foundation
import SwiftUI

struct TestCardsPagee: View {

    var airbaPaySdk: AirbaPaySdk

    @State private var savedCards: [BankCard] = []

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgBlock
            VStack {

                if savedCards.isEmpty {
                    VStack {
                        Text("Нет карт. Вернуться назад")
                    }

                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(ColorsSdk.textBlue)
                            //                       .background(ColorsSdk.bgAPAY)
                            .cornerRadius(8)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 16)
                            .onTapGesture {
                                airbaPaySdk.backToApp()
                            }
                } else {
                    LazyVStack {
                        ForEach(0...savedCards.count - 1, id: \.self) { index in

                            let card = savedCards[index]

                            VStack {
                                Text("Оплатить картой " + (card.getMaskedPanClearedWithPoint()))
                            }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48)
                                    .background(ColorsSdk.textBlue)
                                    .cornerRadius(8)
                                    .padding(.vertical, 16)
                                    .padding(.horizontal, 16)
                                    .onTapGesture {
                                        airbaPaySdk.paySavedCard(bankCard: card, isLoading: { b in }, onError: {})
                                    }

                        }
                    }
                            .padding(.all, 16)


                    VStack {
                        Text("Удалить первую карту в списке")
                    }

                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(ColorsSdk.textBlue)
                            //                       .background(ColorsSdk.bgAPAY)
                            .cornerRadius(8)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 16)
                            .onTapGesture {
                                airbaPaySdk.deleteCard(
                                        cardId: savedCards.first?.id ?? "",
                                        onSuccess: {
                                            airbaPaySdk.getCards(
                                                    onSuccess: { cards in
                                                        savedCards = cards
                                                    },
                                                    onNoCards: { }
                                            )
                                        },
                                        onError: { }
                                )
                            }

                    VStack {
                        Text("Вернуться назад")
                    }

                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(ColorsSdk.textBlue)
                            //                       .background(ColorsSdk.bgAPAY)
                            .cornerRadius(8)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 16)
                            .onTapGesture {
                                airbaPaySdk.backToApp()
                            }
                }
            }
        }
                .onAppear {
                    airbaPaySdk.getCards(
                            onSuccess: { cards in
                                savedCards = cards
                            },
                            onNoCards: { }
                    )

                }
    }
}
