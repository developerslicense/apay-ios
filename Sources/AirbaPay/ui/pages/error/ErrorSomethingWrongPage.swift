//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI

struct ErrorSomethingWrongPage: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    @State var showDialogExit: Bool = false

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgBlock

            GeometryReader { metrics in
                let iconWidth = metrics.size.width * 0.9
                let iconHeight = metrics.size.width * 0.6

                VStack {
                    ViewToolbar(
                            title: "",
                            actionClickBack: { showDialogExit = true }
                    )
                            .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer().frame(height: metrics.size.height * 0.25)

                    Image("icSomethingWrong", bundle: DataHolder.moduleBundle)
                            .resizable()
                            .frame(width: iconWidth, height: iconHeight)
                            .padding(.bottom, 24)

                    Text(somethingWentWrong())
                            .textStyleH3()
                            .frame(alignment: .center)
                            .padding(.bottom, 8)

                    Text(somethingWentWrongDescription())
                            .textStyleBodyRegular()
                            .frame(alignment: .center)

                    Spacer()
                            .frame(height: metrics.size.height * 0.25)
                            .frame(width: metrics.size.width * 1.0)

                }
            }
        }
                .overlay(ViewButton(
                        title: goToMarker(),
                        actionClick: {
                            navigateCoordinator.backToApp()
                        }
                )
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 24)
                        .padding(.horizontal, 16), alignment: .bottom)
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
}

struct ErrorSomethingWrongPage_Previews: PreviewProvider {
    static var previews: some View {
        ErrorSomethingWrongPage(navigateCoordinator: AirbaPayCoordinator())
    }
}
