//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

struct ViewToolbar: View {
    var title: String?
    var actionClickBack: () -> Void

    var body: some View {
        HStack {
            Image("icArrowBack", bundle: DataHolder.moduleBundle)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.black)
                    .padding(.top, 12)
                    .padding(.leading, 12)
                    .onTapGesture(perform: {
                        actionClickBack()
                    })

            Text(title ?? "")
                    .textStyleH0()
                    .padding(.top, 15)
                    .padding(.trailing, 30)
                    .frame(maxWidth: .infinity, alignment: .center)

        }.background(ColorsSdk.bgBlock)
    }
}
