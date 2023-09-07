//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import SwiftUI

struct InitViewStartProcessingAmount: View {
    var body: some View {
        VStack {
            HStack {
                Text(amountOfPurchase()).textStyleRegular()
                Spacer()
                Text(DataHolder.purchaseAmountFormatted)
                        .textStyleSemiBold()
                        .multilineTextAlignment(.trailing)

            }
                    .frame(maxWidth: .infinity)

        }
                .padding()
                .background(ColorsSdk.bgMain)
                .cornerRadius(4)
                .padding(.horizontal, 16)
                .padding(.top, 10)

    }
}
