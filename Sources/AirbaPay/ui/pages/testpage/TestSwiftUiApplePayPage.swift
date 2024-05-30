//
//  TestSwiftUiPage.swift
//
//  Created by Mikhail Belikov on 28.02.2024.
//

import Foundation
import SwiftUI
import UIKit

struct TestSwiftUiApplePayPage: View {

    var airbaPaySdk: AirbaPaySdk

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgBlock
            VStack {


                VStack {
//                   Image("icAPayWhite", bundle: DataHolder.moduleBundle)
                    Text("Тест внешнего API ApplePay через передачу токена")
                }

                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(ColorsSdk.textBlue)
                        //                       .background(ColorsSdk.bgAPAY)
                        .cornerRadius(8)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 16)
                        .onTapGesture {
                            airbaPaySdk.navigateCoordinator.applePay!.buyBtnTapped()
                        }

                VStack {
                    Text("Вернуться назад")
                }

                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(ColorsSdk.textBlue)
                        //                       .background(ColorsSdk.bgAPAY)
                        .cornerRadius(8)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 16)
                        .onTapGesture {
                            airbaPaySdk.backToApp()
                        }
            }
        }
    }
}

