//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI

struct RepeatPage: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    @State var showDialogExit: Bool = false

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgMain

            GeometryReader { metrics in
                VStack {
                    ViewToolbar(
                            title: "",
                            actionShowDialogExit: { showDialogExit = true }
                    )
                            .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer().frame(height: metrics.size.height * 0.30)

                    Text(weRepeatYourPayment())
                            .textStyleH3()
                            .frame(alignment: .center)
                            .padding(.bottom, 8)
                            .frame(width: metrics.size.width * 1.0)

                    Text(thisNeedSomeTime())
                            .textStyleBodyRegular()
                            .frame(alignment: .center)
                            .padding(.bottom, 28)

                    ProgressBarView()

                    Spacer().frame(height: metrics.size.height * 0.25)

                }
            }
        }
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
                .onAppear {

                    Task {
                        if let response = await paymentAccountEntryRetryService() {
                            if response.isSecure3D == true {
                                navigateCoordinator.openWebView(redirectUrl: response.secure3D?.action)

                            } else if (response.errorCode != 0) {
                                navigateCoordinator.openErrorPageWithCondition(
                                        errorCode: response.errorCode ?? 1
                                )

                            } else {
                                navigateCoordinator.openSuccess()
                            }

                        } else {
                            navigateCoordinator.openErrorPageWithCondition(errorCode: 1)
                        }
                    }
                }
    }

}


struct RepeatPage_Previews: PreviewProvider {
    static var previews: some View {
        RepeatPage(navigateCoordinator: AirbaPayCoordinator())
    }
}

