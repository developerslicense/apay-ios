//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI

struct RepeatPage: View {
    @State var showDialogExit: Bool = false
    @EnvironmentObject var router: NavigateUtils.Router

    var body: some View {
        ZStack {
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
                                    DialogExit(onDismissRequest: { showDialogExit = false })
                                })
                )
                .onTapGesture(perform: { showDialogExit = false })
                .onAppear {
                    Task {
                        if let response = await paymentAccountEntryRetryService() {
                            if response.isSecure3D == true {
                                router.route(to: \.webViewPage, response.secure3D?.action)

                            } else if (response.errorCode != "0") {
                                router.route(to: \.errorPage, Int(response.errorCode ?? "1"))

                            } else {
                                router.route(to: \.successPage)
                            }

                        } else {
                            router.route(to: \.errorPage, 1)

                        }
                    }
                }
    }

}


struct RepeatPage_Previews: PreviewProvider {
    static var previews: some View {
        RepeatPage()
    }
}

