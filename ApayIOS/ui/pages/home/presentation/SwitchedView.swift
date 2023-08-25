//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct SwitchedView: View {
    var text: String
    @State var switchCheckedState = false
    var actionOnTrue: () -> Void


    var body: some View {

        Toggle(text, isOn: $switchCheckedState)
                .textStyleSemiBold()
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .tint(ColorsSdk.colorBrandMain)
                .onChange(of: switchCheckedState) { value in
                    if(value) {
                        actionOnTrue()
                    }
                }
    }
}