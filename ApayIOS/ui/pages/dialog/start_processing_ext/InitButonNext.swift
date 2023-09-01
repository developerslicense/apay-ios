//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import SwiftUI

struct InitViewStartProcessingButtonNext: View {
    var savedCards: Array<BankCard>
    var actionClose: () -> Void
    var isAuthenticated: Bool
    var selectedCard: BankCard?


    var body: some View {
        if (!savedCards.isEmpty
                && isAuthenticated
           ) {
            ViewButton(
                    title: payAmount() + " " + DataHolder.purchaseAmountFormatted,
                    actionClick: {
                        actionClose()
                        /*
                val intent = Intent(context, AirbaPayActivity::class.java)
                intent.putExtra(ARG_CARD_ID, selectedCard.value?.id)
                context.startActivity(intent)*/
                    }
            )
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 32)

        } else {
            ViewButton(
                    title: paymentByCard2(),
                    actionClick: {
                        actionClose()
//                        val intent = Intent(context, AirbaPayActivity::class.java)
//                        context.startActivity(intent)
                    }
            )
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 32)
        }
    }
}
