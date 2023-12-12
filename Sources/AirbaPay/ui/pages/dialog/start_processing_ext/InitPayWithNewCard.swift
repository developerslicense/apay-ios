//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import SwiftUI

struct InitViewStartProcessingPayWithNewCard: View {
    var actionClick: () -> Void

    var body: some View {
        Button(
                action: { actionClick() },
                label: {
                    HStack {
                        Spacer()

                        ZStack {
                            Rectangle()
                                    .fill(ColorsSdk.colorBrandMain)
                                    .frame(height: 1.5)
                                    .frame(width: 8)

                            Rectangle()
                                    .fill(ColorsSdk.colorBrandMain)
                                    .frame(height: 8)
                                    .frame(width: 1.5)
                        }


                        Text(payAnotherCard())
                                .foregroundColor(ColorsSdk.colorBrandMain)
                                .textStyleSemiBold()
                                .padding(.leading, 6)
                                .padding(.top, 7)
                                .padding(.bottom, 7)

                        Spacer()
                    }

                            .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                            .stroke(ColorsSdk.gray10, lineWidth: 1)
                            )
                            .frame(width: .infinity)
                            .padding(.horizontal, 16)

                }
        )
    }
}
