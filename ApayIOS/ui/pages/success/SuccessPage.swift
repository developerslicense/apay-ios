//
//  SuccessPage.swift
//  ApayIOS
//
//  Created by Mikhail Belikov on 14.08.2023.
//

import Foundation
import SwiftUI
import WebKit

struct SuccessPage: View {
    var body: some View {
        ZStack {
            ColorSdk.bgBlock
            
            VStack {
                Image("icPaySuccess")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!+")
                        .textStyleH2()
                        .background(ColorSdk.stateSuccess)

              /*  Text("Hello, world!_")
                        .font(Font.custom("Optima-Regular", fixedSize: 24).weight(Font.Weight.ultraLight))
                        .background(ColorSdk.stateSuccess)
                        .foregroundColor(ColorSdk.textMain)*/
            }
        }
    }
}

struct SuccessPage_Previews: PreviewProvider {
    static var previews: some View {
        SuccessPage()
    }
}

/*
 BackHandler {
        (context as Activity).finish()
    }

    ConstraintLayout(
        modifier = Modifier
            .background(ColorsSdk.bgMain)
            .clipToBounds()
            .fillMaxSize()
    ) {

        val (spaceRef, iconRef, textRef, buttonRef) = createRefs()
        Spacer(
            modifier = Modifier
                .fillMaxHeight(0.25f)
                .constrainAs(spaceRef) {
                    top.linkTo(parent.top)
                }
        )
        Image(
            painter = painterResource(R.drawable.pay_success),
            contentDescription = "pay_success",
            modifier = Modifier
                .fillMaxWidth(0.5f)
                .constrainAs(iconRef) {
                    top.linkTo(spaceRef.bottom)
                    start.linkTo(parent.start)
                    end.linkTo(parent.end)
                }
        )

        Text(
            text = paySuccess(),
            style = LocalFonts.current.h3,
            textAlign = TextAlign.Center,
            modifier = Modifier
                .constrainAs(textRef) {
                    top.linkTo(iconRef.bottom, margin = 24.dp)
                    start.linkTo(parent.start)
                    end.linkTo(parent.end)
                }
        )

        ViewButton(
            title = goToMarker(),
            actionClick = {
                (context as Activity).finish()
            },
            modifierRoot = Modifier
                .padding(horizontal = 16.dp)
                .padding(vertical = 20.dp)
                .constrainAs(buttonRef) {
                    bottom.linkTo(parent.bottom)
                    start.linkTo(parent.start)
                    end.linkTo(parent.end)
                }
        )
    }

 */
