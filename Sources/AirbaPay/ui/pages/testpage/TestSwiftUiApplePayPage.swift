//
//  TestSwiftUiApplePayPage.swift
//
//  Created by Mikhail Belikov on 28.02.2024.
//

import Foundation
import SwiftUI

struct TestSwiftUiApplePayPage: View { 
    
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    @StateObject var startProcessingViewModel = StartProcessingViewModel()
    
    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgBlock
            VStack {
                Text("Text up").padding(.all, 16)
                
                if startProcessingViewModel.applePayUrl != nil {
                    ApplePayPage(
                        redirectUrl: startProcessingViewModel.applePayUrl,
                        navigateCoordinator: navigateCoordinator
                    )
                    .frame(maxWidth: .infinity, alignment: .top)
                    .frame(height: 48)
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
                }
                
                Text("Text down").padding(.all, 16)
            }
        }
        .onAppear {
            startProcessingViewModel.onAppear(navigateCoordinator: navigateCoordinator)
        }
    }
}
