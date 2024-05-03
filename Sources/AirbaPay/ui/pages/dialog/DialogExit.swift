//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI

struct DialogExit: View {
    var onDismissRequest: () -> Void
    var backToApp: () -> Void

    var body: some View {

        GeometryReader { metrics in
            let iconSize = metrics.size.width * 0.20

            ZStack {
                ColorsSdk.bgAccent.opacity(0.5)

                VStack {
                    Image("icWarningRedOval", bundle: DataHolder.moduleBundle)
                            .resizable()
                            .frame(width: iconSize, height: iconSize)
                            .padding(.top, 24)

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
                            .padding(.horizontal, 16)


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
                                Logger.log(message: "Был вызван диалог выхода")
                                backToApp()
                            }
                    )
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                            .padding(.top, 8)

                }
                        .background(ColorsSdk.bgBlock)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                        .frame(alignment: .center)
            }
        }
    }
}
