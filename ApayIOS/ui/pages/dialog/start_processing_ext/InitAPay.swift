//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import SwiftUI

internal struct InitViewStartProcessingAPay: View {
    var body: some View {
        VStack {
            Image("icAPayWhite")

        }
                .frame(maxWidth: .infinity)
                .padding()
                .background(ColorsSdk.bgAPAY)
                .cornerRadius(4)
                .padding(.top, 8)
                .padding(.horizontal, 16)
    }
}