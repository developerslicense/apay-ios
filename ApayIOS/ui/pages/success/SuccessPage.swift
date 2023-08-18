//
//  SuccessPage.swift
//  ApayIOS
//
//  Created by Mikhail Belikov on 14.08.2023.
//

import Foundation
import SwiftUI
import WebKit

internal struct SuccessPage: View {
    var body: some View {
        ZStack {
            ColorsSdk.bgMain

            GeometryReader { metrics in
                VStack {
                    Spacer().frame(height: metrics.size.height * 0.30)

                    Image("icPaySuccess")
                            .imageScale(.large)
                            .padding(.bottom, 37)
                            .frame(height: metrics.size.height * 0.25)
                            .frame(width: metrics.size.width * 1.0)

                    Text(paySuccess())
                            .textStyleH3()
                            .frame(alignment: .center)
                            .frame(height: metrics.size.height * 0.10)

                    Spacer().frame(height: metrics.size.height * 0.25)

                    ViewButton(
                            title: goToMarker(),
                            actionClick: {

                            }
                    )
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 24)
                            .padding(.horizontal, 16)
                }
            }
        }
    }
}

internal struct SuccessPage_Previews: PreviewProvider {
    static var previews: some View {
        SuccessPage()
    }
}
