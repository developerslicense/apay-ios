//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI

struct ErrorPage: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    var errorCode: ErrorsCode
    @State var showDialogExit: Bool = false

    init(
            errorCode: ErrorsCode,
            @ObservedObject navigateCoordinator: AirbaPayCoordinator
    ) {
        self.errorCode = errorCode
        self.navigateCoordinator = navigateCoordinator
    }

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgBlock

            GeometryReader { metrics in
                let iconSize = metrics.size.width * 0.60

                VStack {
                    ViewToolbar(
                            title: "",
                            actionShowDialogExit: { showDialogExit = true }
                    )
                            .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer().frame(height: metrics.size.height * 0.15)

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
                .modifier(
                        Popup(
                                isPresented: showDialogExit,
                                content: {
                                    DialogExit(
                                            onDismissRequest: { showDialogExit = false },
                                            backToApp: { navigateCoordinator.backToApp() }
                                    )
                                })
                )
                .onTapGesture(perform: { showDialogExit = false })

    }

    private func initTopButton() -> some View {
        ViewButton(
                title: errorCode.getError().buttonTop(),
                actionClick: {
                    errorCode.getError().clickOnTop(navigateCoordinator: navigateCoordinator)
                }
        )
                .frame(maxWidth: .infinity)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
    }

    private func initBottomButton() -> some View {
        ViewButton(
                title: errorCode.getError().buttonBottom(),
                isMainBrand: false,
                actionClick: {
                    errorCode.getError().clickOnBottom(navigateCoordinator: navigateCoordinator)
                }
        )
                .frame(maxWidth: .infinity)
                .padding(.bottom, 24)
                .padding(.horizontal, 16)
    }
}

struct ErrorPage_Previews: PreviewProvider {
    static var previews: some View {
        ErrorPage(errorCode: ErrorsCode(code: 5009), navigateCoordinator: AirbaPayCoordinator())
    }
}
