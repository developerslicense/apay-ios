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
                                Text(card.name ?? "no name")
                            }

                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48)
                                    .background(ColorsSdk.textBlue)
                                    //                       .background(ColorsSdk.bgAPAY)
                                    .cornerRadius(8)
                                    .padding(.vertical, 16)
                                    .padding(.horizontal, 16)
                                    .onTapGesture {
                                        if card.name?.contains("без FaceId") == true {

                                            airbaPaySdk.paySavedCard(needFaceId: false, bankCard: card, isLoading: {b in }, onError: {} )

                                        } else {
                                            airbaPaySdk.paySavedCard(needFaceId: true, bankCard: card, isLoading: {b in }, onError: {} )
                                        }
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
                                                        if cards != nil {
                                                            savedCards = cards!
                                                        }
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
                    airbaPaySdk.auth(
                            onSuccess: {
                                airbaPaySdk.getCards(
                                        onSuccess: { cards in
                                            if cards != nil {
                                                savedCards = []
                                                cards!.forEach { card in
                                                    if card.getMaskedPanClearedWithPoint().contains("1111") {

                                                        var card1 = card
                                                        card1.name = card.getMaskedPanClearedWithPoint() + " Оплата сохраненной картой c FaceId"
                                                        savedCards.append(card1)

                                                        var card2 = card
                                                        card2.name = card.getMaskedPanClearedWithPoint() + " Оплата сохраненной картой без FaceId"
                                                        savedCards.append(card2)

                                                    } else {
                                                        var card1 = card
                                                        card1.name = card.getMaskedPanClearedWithPoint() + " Оплата сохраненной картой CVV"
                                                        savedCards.append(card1)
                                                    }
                                                }
                                            }
                                        },
                                        onNoCards: { }
                                )
                            },
                            onError: {

                            }
                    )

                }
    }
}
