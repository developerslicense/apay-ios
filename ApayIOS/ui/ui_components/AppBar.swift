//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI

internal extension View {
    func appBar(
            title: String,
            backButtonAction: @escaping () -> Void
    ) -> some View {

        self
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                    backButtonAction()
                }) {
                    Image("ic-back") // set backbutton image here
                            .renderingMode(.template)
                            .foregroundColor(ColorsSdk.gray30)
                })
    }
}