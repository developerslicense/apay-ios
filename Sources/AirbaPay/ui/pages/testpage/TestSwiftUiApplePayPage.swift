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

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgBlock
            VStack {
                Text("Text up").padding(.all, 16)

//                ApplePayView(
//                    redirectFromStoryboardToSwiftUi: nil,
//                    navigateCoordinator: navigateCoordinator,
//                    isLoading: { b in }
//                )
//                .frame(maxWidth: .infinity, alignment: .top)
//                .frame(height: 48)
//                .padding(.top, 8)
//                .padding(.horizontal, 16)

                VStack {
                    Image("icAPayWhite", bundle: DataHolder.moduleBundle)
                }

                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(ColorsSdk.bgAPAY)
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
