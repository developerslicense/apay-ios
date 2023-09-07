//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI
import PathPresenter

struct TestPage1: View {
    @State var path = PathPresenter.Path()
    @State var phone: String = "77051111111"

    var body: some View {
        ZStack {

            PathPresenter.RoutingView(path: $path) {
                ZStack {
                    ColorsSdk.bgMain

                    VStack(alignment: .center) {
                        Text("Можно изменить номер телефона")
                        TextField("", text: $phone)
                                .frame(width: 200, height: 50)
                                .background( ColorsSdk.stateBgWarning)
                                .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                                .stroke(ColorsSdk.gray5, lineWidth: 1)
                                )
                                .padding(.bottom, 150)

                        Button(
                                action: {
                                    path.append(
                                            TestPage2(
                                                back: { path.removeLast() },
                                                phone: phone
                                            )
                                    )
                                },
                                label: {
                                    Text("переход на УСЛОВНЫЙ чекаут")
                                }
                        )
                    }
                }
            }
        }
    }
}


struct TestPage2: View {
    var back: () -> Void
    var phone: String = ""
    @ObservedObject var navigateCoordinator = AirbaPayCoordinator()

    var body: some View {

            AirbaPayView(
                    navigateCoordinator: navigateCoordinator,
                    contentView: {
                        ZStack {
                            ColorsSdk.bgMain
                            VStack {
                                Spacer()
                                Button(
                                        action: {
                                            back()
                                        },
                                        label: {
                                            Text("НАЗАД").foregroundColor(ColorsSdk.colorBrandMain)
                                        }
                                )
                                Spacer(minLength: 50)
                                Button(
                                        action: {
                                            testInitOnCreate(phone: phone)
                                            testInitProcessing()
                                            navigateCoordinator.startProcessing()
                                        },
                                        label: {
                                            Text("переход на эквайринг")
                                        }
                                )
                                Spacer()
                            }
                        }
                    }
            )

    }
}

func testInitOnCreate(phone: String = "77051111111") {
    AirbaPaySdk.initOnCreate(
            isProd: false,
            lang: AirbaPaySdk.Lang.RU(),
            phone: phone,
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
    print("someOrderNumber" + String(someOrderNumber))
    print("someInvoiceId" + String(someInvoiceId))


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
