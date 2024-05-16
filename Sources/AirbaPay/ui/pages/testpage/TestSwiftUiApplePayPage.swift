//
//  TestSwiftUiPage.swift
//
//  Created by Mikhail Belikov on 28.02.2024.
//

import Foundation
import SwiftUI

struct TestSwiftUiApplePayPage: View {

    var airbaPaySdk: AirbaPaySdk

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgBlock
            VStack {
                Text("Text up").padding(.all, 16)


                VStack {
//                   Image("icAPayWhite", bundle: DataHolder.moduleBundle)
                    Text("вебвью")
                }

                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(ColorsSdk.textBlue)
                        //                       .background(ColorsSdk.bgAPAY)
                        .cornerRadius(8)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 16)
                        .onTapGesture {
                            airbaPaySdk.initExternalApplePayWebView()
                        }

                Text("Text middle").padding(.all, 16)


                airbaPaySdk.getApplePayWebView()

                VStack {
//                   Image("icAPayWhite", bundle: DataHolder.moduleBundle)
                    Text("натив")
                }

                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(ColorsSdk.textBlue)
                        //                       .background(ColorsSdk.bgAPAY)
                        .cornerRadius(8)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 16)
                        .onTapGesture {
                            airbaPaySdk.processExternalApplePayNative()
                        }


                Text("Text down").padding(.all, 16)
            }
        }
    }
}
