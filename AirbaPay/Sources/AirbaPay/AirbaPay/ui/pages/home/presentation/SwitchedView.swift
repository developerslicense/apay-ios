//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

struct SwitchedView: View {
    var text: String
    @State var switchCheckedState = false
    var actionOnTrue: () -> Void

    var body: some View {

        if #available(iOS 16.0, *) {
            Toggle(text, isOn: $switchCheckedState)
                    .textStyleSemiBold()
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .tint(ColorsSdk.colorBrandMain)
                    .onChange(of: switchCheckedState) { value in
                        if (value) {
                            actionOnTrue()
                        }
                    }

        } else {
            Toggle(text, isOn: $switchCheckedState)
                    .textStyleSemiBold()
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .onChange(of: switchCheckedState) { value in
                        if (value) {
                            actionOnTrue()
                        }
                    }
        }
    }
}
