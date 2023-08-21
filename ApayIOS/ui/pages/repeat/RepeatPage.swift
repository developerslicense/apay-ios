//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI

internal struct RepeatPage: View {
    var body: some View {
        ZStack {
            ColorsSdk.bgMain

            GeometryReader { metrics in
                VStack {
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
    }

}


internal struct RepeatPage_Previews: PreviewProvider {
    static var previews: some View {
        RepeatPage()
    }
}

/*internal fun RepeatPage(
    navController: NavController,
    paymentsRepository: PaymentsRepository
) {

    BackHandler {}

    ConstraintLayout(
        modifier = Modifier
            .background(ColorsSdk.bgMain)
            .clipToBounds()
            .fillMaxSize()
    ) {

        val (spaceRef, progressRef, textRef, text2Ref) = createRefs()

        Spacer(
            modifier = Modifier
                .fillMaxHeight(0.35f)
                .constrainAs(spaceRef) {
                    top.linkTo(parent.top)
                }
        )

        Text(
            text = weRepeatYourPayment(),
            style = LocalFonts.current.h3,
            textAlign = TextAlign.Center,
            modifier = Modifier
                .constrainAs(textRef) {
                    top.linkTo(spaceRef.bottom)
                    start.linkTo(parent.start)
                    end.linkTo(parent.end)
                }
        )

        Text(
            text = thisNeedSomeTime(),
            style = LocalFonts.current.regular,
            textAlign = TextAlign.Center,
            modifier = Modifier
                .padding(top = 16.dp)
                .constrainAs(text2Ref) {
                    top.linkTo(textRef.bottom)
                    start.linkTo(parent.start)
                    end.linkTo(parent.end)
                }
        )

        CircularProgressIndicator(
            color = ColorsSdk.colorBrandMainMS.value,
            modifier = Modifier
                .padding(top = 24.dp)
                .fillMaxWidth(0.3f)
                .constrainAs(progressRef) {
                    top.linkTo(text2Ref.bottom)
                    start.linkTo(parent.start)
                    end.linkTo(parent.end)
                }
        )
    }

    LaunchedEffect("onStart") {
        launch {
            onStart(
                navController = navController,
                paymentsRepository = paymentsRepository
            )
        }
    }
}

private fun onStart(
    navController: NavController,
    paymentsRepository: PaymentsRepository
) {

    paymentsRepository.paymentAccountEntryRetry(
        result = { response ->
            if (response.isSecure3D == true) {
                openWebView(
                    secure3D = response.secure3D,
                    navController = navController
                )

            } else if (response.errorCode != "0") {
                openErrorPageWithCondition(
                    errorCode = response.errorCode?.toInt() ?: 0,
                    navController = navController
                )

            } else {
                openSuccess(navController)
            }
        },
        error = {
            openErrorPageWithCondition(
                errorCode = ErrorsCode.error_1.code,
                navController = navController
            )
        }
    )

}*/