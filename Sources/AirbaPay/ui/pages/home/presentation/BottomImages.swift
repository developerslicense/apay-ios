//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

struct BottomImages: View {
    var body: some View {
        HStack {
            Image("icPciExpressBlack", bundle: DataHolder.moduleBundle)
                    .resizable()
                    .frame(width: 32, height: 32)
            Spacer()
            Image("icMasterCardBlack", bundle: DataHolder.moduleBundle)
                    .resizable()
                    .frame(width: 32, height: 32)
            Spacer()
            Image("icVisaBlack", bundle: DataHolder.moduleBundle)
                    .resizable()
                    .frame(width: 32, height: 32)
            Spacer()
            Image("icAmericanExpressBlack", bundle: DataHolder.moduleBundle)
                    .resizable()
                    .frame(width: 32, height: 32)
        }
                .frame(maxWidth: .infinity)
                .opacity(0.5)
    }
}
