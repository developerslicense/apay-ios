//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI
import SwiftUI_SimpleToast

struct TestPage: View {
    @State private var sheetState = false

    var body: some View {
        ZStack {
            Button(
                    action: {
                        sheetState = true
                    },
                    label: {
                        Text("перейти на эквайринг")
                    }
            )
        }
                .sheet(isPresented: $sheetState) {
                    StartProcessingView(
                            actionClose: { sheetState = false }
                    )
                            .presentationDetents([.medium, .large])//todo  надо придумать, что с этим сделать для разных случаев
                }

    }
}

func testInitOnCreate() {
    AirbaPaySdk.initOnCreate(
            isProd: false,
            lang: AirbaPaySdk.Lang.RU(),
            phone: "77051111111",
            userEmail: "test@test.com",
            shopId: "test-merchant",
            password: "123456",
            terminalId: "64216e7ccc4a48db060dd689",
            needShowSdkSuccessPage: true,
            failureCallback: "https://site.kz/failure-clb",
            successCallback: "https://site.kz/success-clb" //todo исправь насчет опциональности в документации
//            colorBrandMain = Color.Red
    )
}

func testInitProcessing() {
    let someInvoiceId = Date().timeIntervalSince1970
    let someOrderNumber = Date().timeIntervalSince1970


    let goods = [
        AirbaPaySdk.Goods(
                brand: "Чай Tess Banana Split черный 20 пирамидок",
                category: "Tess",
                model: "Черный чай",
                quantity: 1,
                price: 1000
        ),
        AirbaPaySdk.Goods(
                brand: "Чай Tess Green",
                category: "Tess",
                model: "Green чай",
                quantity: 1,
                price: 500
        )
    ]

    let settlementPayment = [
        AirbaPaySdk.SettlementPayment(
                amount: 1000,
                companyId: "210840019439"
        ),
        AirbaPaySdk.SettlementPayment(
                amount: 500,
                companyId: "254353"
        )
    ]

    AirbaPaySdk.initProcessing(
            purchaseAmount: 1500,
            invoiceId: String(someInvoiceId),
            orderNumber: String(someOrderNumber),
            goods: goods,
            settlementPayments: settlementPayment //todo исправь насчет опциональности в документации
    )
}
