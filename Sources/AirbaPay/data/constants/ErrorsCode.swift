//
// Created by Mikhail Belikov on 16.08.2023.
//

import Foundation

struct ErrorsCode {
    var code: Int = 1

    func getError()-> ErrorsCodeBase {
        switch code {
        case 5002:
            return error_5002
        case 5003:
            return error_5003
        case 5006:
            return error_5006
        case 5007:
            return error_5007
        case 5008:
            return error_5008
        case 5009:
            return error_5009
        case 5999:
            return error_5999
        default:
            return error_1
        }
    }

    let error_1 = ErrorsCodeBase(
            code: 1,
            messageRu: "",
            messageKz: "",
            descriptionRu: "",
            descriptionKz: "",
            buttonTopRu: "",
            buttonTopKz: "",
            buttonBottomRu: "",
            buttonBottomKz: ""
    )
    let error_5002 = ErrorsCodeBase(
            code: 5002,
            messageRu: "Неверный номер карты",
            messageKz: "Карта нөміріндегі қате",
            descriptionRu: tryPayAnotherCardRu,
            descriptionKz: tryPayAnotherCardKz,
            buttonTopRu: payAnotherCardRu,
            buttonTopKz: payAnotherCardKz,
            buttonBottomRu: goToMarketRu,
            buttonBottomKz: goToMarketKz
    )
    let error_5003 = ErrorsCodeBase(
            code: 5003,
            messageRu: "Истек срок карты",
            messageKz: "Картаның мерзімі бітті",
            descriptionRu: tryPayAnotherCardRu,
            descriptionKz: tryPayAnotherCardKz,
            buttonTopRu: payAnotherCardRu,
            buttonTopKz: payAnotherCardKz,
            buttonBottomRu: goToMarketRu,
            buttonBottomKz: goToMarketKz
    )
    let error_5006 = ErrorsCodeBase(
            code: 5006,
            messageRu: "Неверный CVV",
            messageKz: "CVV қатесі",
            descriptionRu: tryPayAnotherCardRu,
            descriptionKz: tryPayAnotherCardKz,
            buttonTopRu: payAnotherCardRu,
            buttonTopKz: payAnotherCardKz,
            buttonBottomRu: goToMarketRu,
            buttonBottomKz: goToMarketKz
    )
    let error_5007 = ErrorsCodeBase(
            code: 5007,
            messageRu: "Недостаточно средств",
            messageKz: "Қаражат жеткіліксіз",
            descriptionRu: "Попробуйте снова или оплатите другой картой",
            descriptionKz: "Қайталап көріңіз немесе басқа картамен төлеңіз",
            buttonTopRu: tryAgainRu,
            buttonTopKz: tryAgainKz,
            buttonBottomRu: goToMarketRu,
            buttonBottomKz: goToMarketKz
    )
    let error_5008 = ErrorsCodeBase(
            code: 5008,
            messageRu: limitExceededRu,
            messageKz: limitExceededKz,
            descriptionRu: "Попробуйте оплатить другой картой или измените лимит в настройках банкинга",
            descriptionKz: "Басқа картамен төлеуге тырысыңыз немесе банк параметрлерінде лимитті өзгертіңіз",
            buttonTopRu: tryAgainRu,
            buttonTopKz: tryAgainKz,
            buttonBottomRu: payAnotherCardRu,
            buttonBottomKz: payAnotherCardKz
    )
    let error_5009 = ErrorsCodeBase(
            code: 5009,
            messageRu: "Неверно введен код 3ds",
            messageKz: "3ds коды қате енгізілді",
            descriptionRu: "Попробуйте повторно ввести код 3Ds",
            descriptionKz: "3D кодын қайта енгізіп көріңіз",
            buttonTopRu: tryAgainRu,
            buttonTopKz: tryAgainKz,
            buttonBottomRu: goToMarketRu,
            buttonBottomKz: goToMarketKz
    )
    let error_5020 = ErrorsCodeBase(
            code: 5020,
            messageRu: "",
            messageKz: "",
            descriptionRu: "",
            descriptionKz: "",
            buttonTopRu: "",
            buttonTopKz: "",
            buttonBottomRu: "",
            buttonBottomKz: ""
    )
    let error_5999 = ErrorsCodeBase(
            code: 5999,
            messageRu: limitExceededRu,
            messageKz: limitExceededKz,
            descriptionRu: "Измените лимит в настройках \nбанкинга и попробуйте снова.\nЛибо оплатите другой картой,",
            descriptionKz: "Банк параметрлерінде шектеуді \nөзгертіп, әрекетті қайталаңыз.\nНемесе басқа картамен төлеңіз",
            buttonTopRu: tryAgainRu,
            buttonTopKz: tryAgainKz,
            buttonBottomRu: payAnotherCardRu,
            buttonBottomKz: payAnotherCardKz
    )
}

struct ErrorsCodeBase: Equatable {
    var code: Int = 1
    var messageRu: String = ""
    var messageKz: String = ""
    var descriptionRu: String = ""
    var descriptionKz: String = ""
    var buttonTopRu: String = ""
    var buttonTopKz: String = ""
    var buttonBottomRu: String = ""
    var buttonBottomKz: String = ""

    func message() -> String {
        if (DataHolder.currentLang == AirbaPaySdk.Lang.KZ()) {
            return messageKz
        } else {
            return messageRu
        }
    }

    func description() -> String {
        if (DataHolder.currentLang == AirbaPaySdk.Lang.KZ()) {
            return descriptionKz
        } else {
            return descriptionRu
        }
    }

    func buttonTop() -> String {
        if (DataHolder.currentLang == AirbaPaySdk.Lang.KZ()) {
            return buttonTopKz
        } else {
            return buttonTopRu
        }
    }

    func buttonBottom() -> String {
        if (DataHolder.currentLang == AirbaPaySdk.Lang.KZ()) {
            return buttonBottomKz
        } else {
            return buttonBottomRu
        }
    }


    func clickOnTop(
            navigateCoordinator: AirbaPayCoordinator
    ) {
        switch code {
        case 5002:
            navigateCoordinator.backToStartPage()

        case 5003:
            navigateCoordinator.backToStartPage()

        case 5006:
            navigateCoordinator.backToStartPage()

        case 5007:
            navigateCoordinator.openRepeat()

        case 5008:
            navigateCoordinator.openRepeat()

        case 5009:
            navigateCoordinator.openRepeat()

        case 5999:
            navigateCoordinator.openRepeat()

        default:
            navigateCoordinator.backToApp()
        }
    }

    func clickOnBottom(
            navigateCoordinator: AirbaPayCoordinator
    ) {
        switch code {
        case 5008:
            navigateCoordinator.backToStartPage()

        case 5999:
            navigateCoordinator.backToStartPage()

        default:
            navigateCoordinator.backToApp()
        }
    }

    private func recreatePayment() async {

        let authParams = AuthRequest(
                password: DataHolder.password,
                paymentId: nil,
                terminalId: DataHolder.terminalId,
                user: DataHolder.shopId
        )

        if let res = await authService(params: authParams) {
            await startCreatePayment()

        }

    }

    func startCreatePayment() async {
        if let result: PaymentCreateResponse = await createPaymentService() {
            let authParams = AuthRequest(
                    password: DataHolder.password,
                    paymentId: result.id,
                    terminalId: DataHolder.terminalId,
                    user: DataHolder.shopId
            )

            if let res = await authService(params: authParams) {

            }

        }
    }

}

