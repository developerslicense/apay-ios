//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

struct BottomImages: View {
    var body: some View {
        HStack {
            Image("icPciExpressBlack")
                    .resizable()
                    .frame(width: 32, height: 32)
            Spacer()
            Image("icMasterCardBlack")
                    .resizable()
                    .frame(width: 32, height: 32)
            Spacer()
            Image("icVisaBlack")
                    .resizable()
                    .frame(width: 32, height: 32)
            Spacer()
            Image("icAmericanExpressBlack")
                    .resizable()
                    .frame(width: 32, height: 32)
        }
                .frame(maxWidth: .infinity)
    }
}
