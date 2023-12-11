//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

struct InitHeader: View {
    var title: String
    var actionClose: (() -> Void)?

    var body: some View {
        VStack {

            Image("icGrayLine")
                    .padding(.top, 11)

            ZStack {

                Text(title)
                        .textStyleSubtitleBold()
                        .frame(width: .infinity, alignment: .center)


                if (actionClose != nil) {
                    Image("icCancel", bundle: DataHolder.moduleBundle)
                            .padding(.horizontal, 16)
                            .onTapGesture {
                                actionClose!()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                }
            }.frame(height: 45)

            Divider()

        }
    }
}
