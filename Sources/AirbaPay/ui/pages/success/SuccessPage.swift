//
//  SuccessPage.swift
//  ApayIOS
//
//  Created by Mikhail Belikov on 14.08.2023.
//

import Foundation
import SwiftUI
import WebKit

struct SuccessPage: View {
    var navigateCoordinator: AirbaPayCoordinator

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgBlock

            GeometryReader { metrics in
                let iconSize = metrics.size.width * 0.60

                VStack {
                    Spacer().frame(height: metrics.size.height * 0.20)

                    Image("icPaySuccess", bundle: DataHolder.moduleBundle)
                            .resizable()
                            .frame(width: iconSize, height: iconSize)
                            .padding(.bottom, 37)

                    Text(paySuccess())
                            .textStyleH3()
                            .frame(alignment: .center)

                    Spacer()
                            .frame(height: metrics.size.height * 0.35)
                            .frame(width: metrics.size.width * 1.0)


                }
            }

        }
                .overlay(ViewButton(
                        title: goToMarker(),
                        actionClick: {
                            navigateCoordinator.backToApp(result: true)
                        }
                )
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 24)
                        .padding(.horizontal, 16), alignment: .bottom)
    }
}

