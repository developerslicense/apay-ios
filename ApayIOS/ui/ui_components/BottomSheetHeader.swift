//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct InitHeader: View {
    var title: String
    var actionClose: (() -> Void)?

    var body: some View {
        VStack {

            ZStack {

                Text(title)
                        .textStyleSubtitleBold()
                        .padding(.top, 16)
                        .frame(width: .infinity, alignment: .center)


                if (actionClose != nil) {
                    Image("icCancel")
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                            .onTapGesture {
                                actionClose!()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                }
            }.frame(height: 46)

            Divider().padding(.top, 6)

        }
    }
}
