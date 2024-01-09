//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI

struct ErrorFinalPage: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator

    var body: some View {
        ZStack {
            ColorsSdk.gray30
            ColorsSdk.bgBlock

            GeometryReader { metrics in
                let iconSize = metrics.size.width * 0.60

                VStack {

                    Spacer().frame(height: metrics.size.height * 0.17)

                    Image("icPayFailed", bundle: DataHolder.moduleBundle)
                            .resizable()
                            .frame(width: iconSize, height: iconSize)
                            .padding(.bottom, 24)

                    Text(timeForPayExpired())
                            .textStyleH3()
                            .frame(alignment: .center)
                            .padding(.bottom, 8)

                    Text(tryFormedNewCart())
                            .multilineTextAlignment(.center)
                            .textStyleBodyRegular()
                            .frame(alignment: .center)

                    Spacer()
                            .frame(height: metrics.size.height * 0.31)
                            .frame(width: metrics.size.width)

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
    }
}

struct ErrorFinalPage_Previews: PreviewProvider {
    static var previews: some View {
        ErrorFinalPage(navigateCoordinator: AirbaPayCoordinator())
    }
}
