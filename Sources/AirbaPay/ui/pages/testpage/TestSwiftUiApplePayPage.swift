//
//  TestSwiftUiPage.swift
//
//  Created by Mikhail Belikov on 28.02.2024.
//

import Foundation
import SwiftUI

struct TestSwiftUiApplePayPage: View {

    @ObservedObject var navigateCoordinator: AirbaPayCoordinator

    var applePay: ApplePayManager
    var applePayViewModel: ApplePayViewModel = ApplePayViewModel()

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
                            applePayViewModel.auth(
                                    onError: {

                                    },
                                    onSuccess: {

                                    }
                            )
                        }

                Text("Text middle").padding(.all, 16)


                ApplePayWebViewExternal(
                        redirectFromStoryboardToSwiftUi: nil,
                        navigateCoordinator: navigateCoordinator,
                        applePayViewModel: applePayViewModel
                )

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
                            applePay.buyBtnTapped()
                        }


                Text("Text down").padding(.all, 16)
            }
        }
    }
}
