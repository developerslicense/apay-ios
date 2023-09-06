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
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgMain

            GeometryReader { metrics in
                let iconSize = metrics.size.width * 0.60

                VStack {
                    Spacer().frame(height: metrics.size.height * 0.20)

                    Image("icPaySuccess")
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
                            navigateCoordinator.backToApp()
                        }
                )
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 24)
                        .padding(.horizontal, 16), alignment: .bottom)
    }
}

struct SuccessPage_Previews: PreviewProvider {
    static var previews: some View {
        SuccessPage(navigateCoordinator: AirbaPayCoordinator())
    }
}
