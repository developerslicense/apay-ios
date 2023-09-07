//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

struct TopInfoView: View {
    var purchaseAmount: String

    var body: some View {
        VStack {
            HStack {
                Text(amountOfPurchase()).textStyleRegular()
                Spacer()
                Text(purchaseAmount)
                        .textStyleSemiBold()
                        .multilineTextAlignment(.trailing)

            }
                    .frame(maxWidth: .infinity)


            HStack {
                Text(numberOfPurchase()).textStyleRegular()
                Spacer()
                Text(DataHolder.orderNumber)
                        .textStyleSemiBold()
                        .multilineTextAlignment(.trailing)

            }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
        }
                .padding()
                .background(ColorsSdk.bgMain)
                .cornerRadius(8)

    }
}
