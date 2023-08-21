//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI

internal struct ErrorSomethingWrongPage: View{
    var body: some View {
        ZStack {
            ColorsSdk.bgMain

            GeometryReader { metrics in
                VStack {
                    Spacer().frame(height: metrics.size.height * 0.30)

                    Image("icSomethingWrong")
                            .imageScale(.large)
                            .padding(.bottom, 24)

                    Text(somethingWentWrong())
                            .textStyleH3()
                            .frame(alignment: .center)
                            .padding(.bottom, 8)

                    Text(somethingWentWrongDescription())
                            .textStyleBodyRegular()
                            .frame(alignment: .center)

                    Spacer().frame(height: metrics.size.height * 0.25)

                    ViewButton(
                            title: goToMarker(),
                            actionClick: {

                            }
                    )
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 24)
                            .padding(.horizontal, 16)
                }
            }
        }
    }
}

internal struct ErrorSomethingWrongPage_Previews: PreviewProvider {
    static var previews: some View {
        ErrorSomethingWrongPage()
    }
}
