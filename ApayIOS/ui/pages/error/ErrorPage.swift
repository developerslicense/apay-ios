//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI

struct ErrorPage: View {

    var errorCode: ErrorsCode
    /*val showDialogExit = remember {
        mutableStateOf(false)
    }

    BackHandler {
        showDialogExit.value = true
    }*/

    var body: some View {
        ZStack {
            ColorsSdk.bgMain

            GeometryReader { metrics in
                let iconSize = metrics.size.width * 0.60

                VStack {
                    Spacer().frame(height: metrics.size.height * 0.15)

                    Image("icPayFailed")
                            .resizable()
                            .frame(width: iconSize, height: iconSize)
                            .padding(.bottom, 24)

                    Text(errorCode.getError().message())
                            .textStyleH3()
                            .frame(alignment: .center)
                            .padding(.bottom, 8)

                    Text(errorCode.getError().description())
                            .multilineTextAlignment(.center)
                            .textStyleBodyRegular()
                            .frame(alignment: .center)

                    Spacer()
                            .frame(height: metrics.size.height * 0.31)
                            .frame(width: metrics.size.width)

                }

            }
        }
                .overlay(
                        VStack {
                            initTopButton()
                            initBottomButton()
                        },
                        alignment: .bottom
                )

    }

    private func initTopButton() -> some View {
        ViewButton(
                title: errorCode.getError().buttonTop(),
                actionClick: {

                }
        )
                .frame(maxWidth: .infinity)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
    }

    private func initBottomButton() -> some View {
        ViewButton(
                title: errorCode.getError().buttonBottom(),
                isMainBrand: false,
                actionClick: {

                }
        )
                .frame(maxWidth: .infinity)
                .padding(.bottom, 24)
                .padding(.horizontal, 16)
    }
}

struct ErrorPage_Previews: PreviewProvider {
    static var previews: some View {
        ErrorPage(errorCode: ErrorsCode(code: 5009))
    }
}
