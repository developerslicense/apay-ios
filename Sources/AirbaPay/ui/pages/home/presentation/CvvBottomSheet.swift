//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

struct CvvBottomSheet: View {
//    @Environment(\.dismiss) var dismiss

    @State var presentSheet: Bool = false
    @State var detentHeight: CGFloat = 0

    var body: some View {
        if #available(iOS 16.0, *) {
            ColorsSdk.bgBlock.overlay(
                    VStack {
                        InitHeader(
                                title: "CVV",
                                actionClose: {
//                                dismiss()
                                }
                        )

                        Text(cvvInfo())
                                .textStyleRegular()
                                .padding(.horizontal, 16)
                                .padding(.top, 22)

                        Text(cvvInfo2())
                                .textStyleRegular()
                                .padding(.horizontal, 16)
                                .padding(.bottom, 32)

                    }
                            .readHeight()
                            .onPreferenceChange(HeightPreferenceKey.self) { height in
                                if let height {
                                    self.detentHeight = height
                                }
                            }
                            .presentationDetents([.height(detentHeight)])
            )

        } else {
            ColorsSdk.bgBlock.overlay(
                    VStack {
                        InitHeader(
                                title: "CVV",
                                actionClose: {
//                                dismiss()
                                }
                        )

                        Text(cvvInfo())
                                .textStyleRegular()
                                .padding(.horizontal, 16)
                                .padding(.top, 22)

                        Text(cvvInfo2())
                                .textStyleRegular()
                                .padding(.horizontal, 16)
                                .padding(.bottom, 32)

                    }
                            .readHeight()
                            .onPreferenceChange(HeightPreferenceKey.self) { height in
                                if let height {
                                    self.detentHeight = height
                                }
                            }
            )
        }
    }

}
