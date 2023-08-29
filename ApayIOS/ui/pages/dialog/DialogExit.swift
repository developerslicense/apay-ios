//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI

struct DialogExit: View {
    var onDismissRequest: () -> Void

    var body: some View {

        GeometryReader { metrics in
            let iconSize = metrics.size.width * 0.20
            let dialogHeight = iconSize * 5

            ZStack {
                ColorsSdk.bgAccent.opacity(0.5)

                ColorsSdk.bgBlock
                        .overlay(
                                VStack {
                                    Image("icWarningRedOval")
                                            .resizable()
                                            .frame(width: iconSize, height: iconSize)

                                    Text(dropPayment())
                                            .textStyleSubtitleBold()
                                            .frame(alignment: .center)
                                            .padding(.top, 16)

                                    Text(dropPaymentDescription())
                                            .multilineTextAlignment(.center)
                                            .textStyleBodyRegular()
                                            .frame(alignment: .center)
                                            .padding(.top, 8)
                                            .padding(.bottom, 24)

                                    ViewButton(
                                            title: no(),
                                            actionClick: {
                                                onDismissRequest()
                                            }
                                    )
                                            .frame(maxWidth: .infinity)
                                            .padding(.horizontal, 16)

                                    ViewButton(
                                            title: yes(),
                                            isMainBrand: false,
                                            actionClick: {
                                                onDismissRequest()
                                                //todo возврат назад
                                            }
                                    )
                                            .frame(maxWidth: .infinity)
                                            .padding(.horizontal, 16)

                                }
                        )
                        .cornerRadius(8)
                        .padding(16)
                        .frame(height: dialogHeight)
                        .frame(width: metrics.size.width * 0.8)
            }
                    .frame(width: metrics.size.width)
        }
    }
}
