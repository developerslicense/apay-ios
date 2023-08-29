//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import SwiftUI

struct InitErrorState: View {
    var body: some View {
        VStack {
            Image("icSomethingWrong")
                    .padding(.top, 24)
                    .padding(.bottom, 24)

            Text(somethingWentWrong())
                    .textStyleH3()
                    .frame(width: .infinity)
                    .frame(alignment: .center)
                    .padding(.bottom, 20)


        }
                .frame(width: .infinity, alignment: .center)
    }
}
