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
                    Text("ApplePay внешний АПИ SwiftUI")
                }

                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(ColorsSdk.textBlue)
                        //                       .background(ColorsSdk.bgAPAY)
                        .cornerRadius(8)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 16)
                        .onTapGesture {
                            airbaPaySdk.processExternalApplePay()
                        }

                VStack {
//                   Image("icAPayWhite", bundle: DataHolder.moduleBundle)
                    Text("ApplePay внешний АПИ UIKit (не работает в тестовом приложении, только в чистом UIKit)")
                }

                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(ColorsSdk.textBlue)
                        //                       .background(ColorsSdk.bgAPAY)
                        .cornerRadius(8)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 16)
                        .onTapGesture {
                            airbaPaySdk.processExternalApplePay(uiViewController: UIViewController())
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

