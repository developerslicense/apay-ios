//
// Created by Mikhail Belikov on 14.09.2023.
//

import Foundation
import SwiftUI


struct CardScannerPage: View {
    var onSuccess: (String) -> Void
    var onBackEmpty: () -> Void

    var body: some View {

        GeometryReader { geometry in
            ZStack {
                ColorsSdk.bgBlock
                ColorsSdk.bgAccent.opacity(0.9)

                VStack(alignment: .leading) {
//                    ViewToolbar(
//                            title: "",
//                            actionClickBack: {
//                                TorchHolder.torch = nil
//                                onBackEmpty()
//                            }
//                    )
//                            .frame(maxWidth: .infinity, alignment: .leading)

                    Image("icFlash", bundle: DataHolder.moduleBundle)
                            .padding(.top, 24)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 100)
                            .onTapGesture {
                                TorchHolder.observer?.clickOnTorch()
                            }

                    VStack {
                        CardScanner()
                                .onDismiss {
                                    // Do something when the view dismissed.
                                }
                                .onError { error in
                                    // The 'error' above gives you 'CreditCardScannerError' struct below.
                                    print(error)
                                    onBackEmpty()
                                }
                                .onSuccess { card in
                                    // The card above gives you 'CreditCard' struct below.

                                    print(card)
                                    if card.number != nil {
                                        onSuccess(card.number!)
                                    } else {
                                        onBackEmpty()
                                    }
                                }
                    }
                            .frame(width: .infinity, height: geometry.size.height / 3)
                            .background(ColorsSdk.transparent)
                            .border(ColorsSdk.colorBrandMain, width: 5)
                            .cornerRadius(16)
                            .padding(.horizontal, 16)

                    Spacer()

                }
            }
        }

    }
}
