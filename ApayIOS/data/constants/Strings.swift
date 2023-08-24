//
// Created by Mikhail Belikov on 16.08.2023.
//

import Foundation

// эти исключения из-за того, что в enum используются
internal let tryAgainRu = "Попробовать снова"
internal let tryAgainKz = "Қайтадан байқап көріңіз"

internal let payAnotherCardRu = "Оплатить другой картой"
internal let payAnotherCardKz = "Басқа картамен төлеңіз"

internal let goToMarketRu = "Вернуться в магазин"
internal let goToMarketKz = "Дүкенге оралу"

internal let limitExceededRu = "Превышен лимит \nпо карте"
internal let limitExceededKz = "Карта шегінен \nасып кетті"

internal let tryPayAnotherCardRu = "Попробуйте оплатить другой картой"
internal let tryPayAnotherCardKz = "Басқа картамен төлеуге тырысыңыз"

internal let kzt = "₸"

internal func paymentByCard() -> String {
    getStrFromRes("Оплата картой", "Карточка арқылы төлеу")
}

internal func paymentByCard2() -> String {
    getStrFromRes("Оплатить картой", "Картамен төлеу")
}

internal func paymentOfPurchase() -> String {
    getStrFromRes("Оплата покупки", "Сатып алу төлемі")
}

internal func amountOfPurchase() -> String {
    getStrFromRes("Сумма покупки", "Сатып алу сомасы")
}

internal func numberOfPurchase() -> String {
    getStrFromRes("Номер заказа", "Тапсырыс нөмірі")
}


internal func holderName() -> String {
    getStrFromRes("Имя держателя", "Ұстаушы аты")
}


internal func cardNumber() -> String {
    getStrFromRes("Номер карты", "Карта нөмірі")
}

internal func dateExpired() -> String {
    getStrFromRes("ММ/ГГ", "АА/ЖЖ")
}

internal func cvv() -> String {
    getStrFromRes("CVV", "CVV")
}


internal func saveCardData() -> String {
    getStrFromRes("Сохранить данные карты", "Карта мәліметтерін сақтаңыз")
}

internal func sendCheckToEmail() -> String {
    getStrFromRes("Отправить чек на e-mail", "Чекті электрондық поштаға жіберіңіз")
}


internal func email() -> String {
    getStrFromRes("E-mail", "E-mail")
}


internal func payAmount() -> String {
    getStrFromRes("Оплатить", "Төлеу")
}


internal func cvvInfo() -> String {
    getStrFromRes(
            "CVV находится на задней стороне",
            "CVV төлем картаңыздың артында"
    )
}

internal func cvvInfo2() -> String {
    getStrFromRes(
            "вашей платежной карты",
            "орналасқан"
    )
}


internal func cardDataSaved() -> String {
    getStrFromRes("Данные карты сохранены", "Карта деректері сақталды")
}


internal func needFillTheField() -> String {
    getStrFromRes("Заполните поле", "Өрісті толтырыңыз")
}


internal func wrongDate() -> String {
    getStrFromRes("Неверная дата", "Қате күн")
}


internal func wrongEmail() -> String {
    getStrFromRes("Неверный емейл", "Жарамсыз электрондық пошта")
}


internal func wrongCvv() -> String {
    getStrFromRes("Неверный CVV", "Жарамсыз CVV")
}


internal func wrongCardNumber() -> String {
    getStrFromRes("Неправильный номер карты", "Карта нөмірі қате")
}


internal func yes() -> String {
    getStrFromRes("Да", "Иә")
}


internal func no() -> String {
    getStrFromRes("Нет", "Жоқ")
}


internal func dropPayment() -> String {
    getStrFromRes("Прервать оплату?", "Төлемді тоқтату керек пе?")
}


internal func paySuccess() -> String {
    getStrFromRes("Оплата прошла успешно", "Төлем сәтті болды")
}


internal func goToMarker() -> String {
    getStrFromRes(goToMarketRu, goToMarketKz)
}


internal func dropPaymentDescription() -> String {
    getStrFromRes(
            "Нажимая “Да” введенные карточные данные не будут сохранены",
            "«Иә» түймесін басу арқылы енгізілген карта деректері сақталмайды"
    )
}


internal func timeForPayExpired() -> String {
    getStrFromRes("Время оплаты истекло", "Төлеу уақыты аяқталды")
}


internal func tryFormedNewCart() -> String {
    getStrFromRes(
            "Попробуйте сформировать\nкорзину занова",
            "Себетті қайтадан\nжасап көріңіз"
    )
}


internal func weRepeatYourPayment() -> String {
    getStrFromRes("Повторяем ваш платеж", "Төлеміңізді қайталаймыз")
}


internal func thisNeedSomeTime() -> String {
    getStrFromRes("Это займет немного времени", "Бұл біраз уақытты алады")
}


internal func forChangeLimitInKaspi() -> String {
    getStrFromRes(
            "Для изменения лимита \nв приложении Kaspi.kz:",
            "Kaspi.kz қолданбасындағы \nшектеуді өзгерту үшін:"
    )
}


internal func forChangeLimitInHomebank() -> String {
    getStrFromRes(
            "Для изменения лимита \nв приложении Homebank:",
            "Homebank қолданбасындағы \nшектеуді өзгерту үшін:"
    )
}


internal func somethingWentWrong() -> String {
    getStrFromRes("Что-то пошло не так", "Бірдеңе дұрыс болмады")
}


internal func somethingWentWrongDescription() -> String {
    getStrFromRes(
            "Обратитесь в службу поддержки магазина",
            "Дүкен қолдау қызметіне хабарласыңыз"
    )
}

internal func orPayWithCard() -> String {
    getStrFromRes(
            "или оплатите картой",
            "немесе картамен төлеңіз"
    )
}

internal func payAnotherCard() -> String {
    getStrFromRes(
            payAnotherCardRu,
            payAnotherCardKz
    )
}

internal func accessToCardRestricted() -> String {
    getStrFromRes(
            "Доступ к сохраненным картам отменен",
            "Сақталған карталарға кіруден бас тартылды"
    )
}

internal func requestAccessToSavedCards() -> String {
    getStrFromRes(
            "Запрос доступа к сохраненным картам",
            "Сақталған карталарға рұқсат сұрау"
    )
}

internal func authenticateFingerprint() -> String {
    getStrFromRes(
            "Отсканируйте отпечаток пальца",
            "Саусақ ізін сканерлеңіз"
    )
}

internal func textCancel() -> String {
    getStrFromRes(
            "Отменить",
            "Бас тарту"
    )
}
