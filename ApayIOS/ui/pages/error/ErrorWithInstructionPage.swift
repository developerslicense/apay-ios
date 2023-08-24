//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI

internal struct ErrorWithInstructionPage: View {

    private let errorCode: ErrorsCode = ErrorsCode(code: 5999)
    @State private var isPlayedOnce = false
    /*val showDialogExit = remember {
        mutableStateOf(false)
    }

    BackHandler {
        showDialogExit.value = true
    }*/

    /* try {
      bankName = ModalRoute.of(context)?.settings.arguments as String

    } catch (e) {
      bankName = BanksName.kaspi.name
    }*/

    var body: some View {
        ZStack {
            ColorsSdk.bgMain

            GeometryReader { metrics in
                let iconSize = metrics.size.width * 0.30
                let webViewHeight = metrics.size.width * 0.6

                ScrollView {

                    VStack {
                        Spacer().frame(height: metrics.size.height * 0.05)

                        Image("icPayFailed")
                                .resizable()
                                .frame(width: iconSize, height: iconSize)
                                .padding(.bottom, 24)

                        Text(errorCode.getError().message())
                                .multilineTextAlignment(.center)
                                .textStyleH3()
                                .frame(alignment: .center)
                                .padding(.bottom, 8)

                        Text(errorCode.getError().description())
                                .multilineTextAlignment(.center)
                                .textStyleBodyRegular()
                                .frame(alignment: .center)
                                .padding(.bottom, 32)

                        Text(DataHolder.bankName == BanksName.kaspibank ? forChangeLimitInKaspi() : forChangeLimitInHomebank())
                                .multilineTextAlignment(.leading)
                                .textStyleSemiBold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 16)

                        if (!isPlayedOnce) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: webViewHeight)
                                        .padding(.horizontal, 16)
                                        .padding(.top, 16)
                                        .foregroundColor(ColorsSdk.gray10)
                                        .offset(y: -20)
                                ZStack {
                                    Image("icPlay")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                }
                            }
                                    .onTapGesture {
                                        isPlayedOnce = true
                                    }

                        } else {
                            InstructionWebViewClient()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: webViewHeight)
                                    .padding(.horizontal, 16)
                                    .padding(.top, 16)
                        }

                        Spacer()
                                .frame(height: metrics.size.height * 0.31)
                                .frame(width: metrics.size.width)

                    }

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

internal struct ErrorWithInstructionPage_Previews: PreviewProvider {
    static var previews: some View {
        ErrorWithInstructionPage()
    }
}