//
// Created by Mikhail Belikov on 16.08.2023.
//

import Foundation

internal class ErrorsCode {
    static let error_1 = ErrorsCodeBase(
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
    static let error_5002 = ErrorsCodeBase(
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
    static let error_5003 = ErrorsCodeBase(
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
    static let error_5006 = ErrorsCodeBase(
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
    static let error_5007 = ErrorsCodeBase(
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
    static let error_5008 = ErrorsCodeBase(
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
    static let error_5009 = ErrorsCodeBase(
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
    static let error_5020 = ErrorsCodeBase(
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
    static let error_5999 = ErrorsCodeBase(
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

internal struct ErrorsCodeBase {
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
//            navController: NavController,
            finish: () -> Void
    ) {
        /*switch code {
            case 5002:
                    backToHome(navController)

            case 5003:
                    backToHome(navController)

            case 5006:
                    backToHome(navController)

            case 5007:
                    openRepeat(navController)

            case 5008:
                    openRepeat(navController)

            case 5009:
                    openRepeat(navController)

            case 5999:
                    openRepeat(navController)
            default:
                    finish()
        }*/
    }

    func clickOnBottom(
//        navController: NavController,
            finish: () -> Void
    ) {
       /* switch code {
        case 5008:
            backToHome(navController)

        case 5999:
            backToHome(navController)

        default:
            finish()
        }*/
    }
}

internal func initErrorsCodeByCode(code: Int) -> ErrorsCodeBase {
    switch code {
    case 5002:
        return ErrorsCode.error_5002
    case 5003:
        return ErrorsCode.error_5003
    case 5006:
        return ErrorsCode.error_5006
    case 5007:
        return ErrorsCode.error_5007
    case 5008:
        return ErrorsCode.error_5008
    case 5009:
        return ErrorsCode.error_5009
    case 5999:
        return ErrorsCode.error_5999
    default:
        return ErrorsCode.error_1
    }
}


/*let error_1 = ErrorsCodeBase(
        code: Int = 1,
        messageRu: String = "",
        messageKz: String = "",
        descriptionRu: String = "",
        descriptionKz: String = "",
        buttonTopRu: String = "",
        buttonTopKz: String = "",
        buttonBottomRu: String = "",
        buttonBottomKz: String = ""
)
    case error_5002(
            code: Int = 5002,
            messageRu: String = "Неверный номер карты",
            messageKz: String = "Карта нөміріндегі қате",
            descriptionRu: String = tryPayAnotherCardRu,
            descriptionKz: String = tryPayAnotherCardKz,
            buttonTopRu: String = payAnotherCardRu,
            buttonTopKz: String = payAnotherCardKz,
            buttonBottomRu: String = goToMarketRu,
            buttonBottomKz: String = goToMarketKz
    )
    case error_5003(
            code: Int = 5003,
            messageRu: String = "Истек срок карты",
            messageKz: String = "Картаның мерзімі бітті",
            descriptionRu: String = tryPayAnotherCardRu,
            descriptionKz: String = tryPayAnotherCardKz,
            buttonTopRu: String = payAnotherCardRu,
            buttonTopKz: String = payAnotherCardKz,
            buttonBottomRu: String = goToMarketRu,
            buttonBottomKz: String = goToMarketKz
    )
    case error_5006(
            code: Int = 5006,
            messageRu: String = "Неверный CVV",
            messageKz: String = "CVV қатесі",
            descriptionRu: String = tryPayAnotherCardRu,
            descriptionKz: String = tryPayAnotherCardKz,
            buttonTopRu: String = payAnotherCardRu,
            buttonTopKz: String = payAnotherCardKz,
            buttonBottomRu: String = goToMarketRu,
            buttonBottomKz: String = goToMarketKz
    )
    case error_5007(
            code: Int = 5007,
            messageRu: String = "Недостаточно средств",
            messageKz: String = "Қаражат жеткіліксіз",
            descriptionRu: String = "Попробуйте снова или оплатите другой картой",
            descriptionKz: String = "Қайталап көріңіз немесе басқа картамен төлеңіз",
            buttonTopRu: String = tryAgainRu,
            buttonTopKz: String = tryAgainKz,
            buttonBottomRu: String = goToMarketRu,
            buttonBottomKz: String = goToMarketKz
    )
    case error_5008(
            code: Int = 5008,
            messageRu: String = limitExceededRu,
            messageKz: String = limitExceededKz,
            descriptionRu: String = "Попробуйте оплатить другой картой или измените лимит в настройках банкинга",
            descriptionKz: String = "Басқа картамен төлеуге тырысыңыз немесе банк параметрлерінде лимитті өзгертіңіз",
            buttonTopRu: String = tryAgainRu,
            buttonTopKz: String = tryAgainKz,
            buttonBottomRu: String = payAnotherCardRu,
            buttonBottomKz: String = payAnotherCardKz
    )
    case error_5009(
            code: Int = 5009,
            messageRu: String = "Неверно введен код 3ds",
            messageKz: String = "3ds коды қате енгізілді",
            descriptionRu: String = "Попробуйте повторно ввести код 3Ds",
            descriptionKz: String = "3D кодын қайта енгізіп көріңіз",
            buttonTopRu: String = tryAgainRu,
            buttonTopKz: String = tryAgainKz,
            buttonBottomRu: String = goToMarketRu,
            buttonBottomKz: String = goToMarketKz
    )
    case error_5020(
            code: Int = 5020,
            messageRu: String = "",
            messageKz: String = "",
            descriptionRu: String = "",
            descriptionKz: String = "",
            buttonTopRu: String = "",
            buttonTopKz: String = "",
            buttonBottomRu: String = "",
            buttonBottomKz: String = ""
    )
    case error_5999(
            code: Int = 5999,
            messageRu: String = limitExceededRu,
            messageKz: String = limitExceededKz,
            descriptionRu: String = "Измените лимит в настройках \nбанкинга и попробуйте снова.\nЛибо оплатите другой картой,",
            descriptionKz: String = "Банк параметрлерінде шектеуді \nөзгертіп, әрекетті қайталаңыз.\nНемесе басқа картамен төлеңіз",
            buttonTopRu: String = tryAgainRu,
            buttonTopKz: String = tryAgainKz,
            buttonBottomRu: String = payAnotherCardRu,
            buttonBottomKz: String = payAnotherCardKz
    )
*/