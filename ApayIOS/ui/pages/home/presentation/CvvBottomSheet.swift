//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI

internal struct CvvBottomSheet: View {
    var  actionClose: () -> Void

    var body: some View {
        VStack {}
    }
}

/* Card(
        shape = RoundedCornerShape(
            topStart = 12.dp,
            topEnd = 12.dp
        ),
        modifier = Modifier.fillMaxWidth()
    ) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,

            ) {

            InitHeader(
                title = "CVV",
                actionClose = actionClose,
                modifier = Modifier
                    .fillMaxWidth()
                    .background(ColorsSdk.gray0)
            )

            Text(
                text = cvvInfo(),
                style = LocalFonts.current.regular,
                modifier = Modifier
                    .padding(horizontal = 16.dp)
                    .padding(bottom = 32.dp)
                    .padding(top = 22.dp)
            )
        }
    }*/