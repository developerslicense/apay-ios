//
// Created by Mikhail Belikov on 16.08.2023.
//

import Foundation

// эти исключения из-за того, что в enum используются
let tryAgainRu = "Попробовать снова"
let tryAgainKz = "Қайтадан байқап көріңіз"

let payAnotherCardRu = "Оплатить другой картой"
let payAnotherCardKz = "Басқа картамен төлеңіз"

let goToMarketRu = "Вернуться в магазин"
let goToMarketKz = "Дүкенге оралу"

let limitExceededRu = "Превышен лимит \nпо карте"
let limitExceededKz = "Карта шегінен \nасып кетті"

let tryPayAnotherCardRu = "Попробуйте оплатить другой картой"
let tryPayAnotherCardKz = "Басқа картамен төлеуге тырысыңыз"

let kzt = "₸"

func paymentByCard() -> String {
    getStrFromRes("Оплата картой", "Карточка арқылы төлеу")
}

func paymentByCard2() -> String {
    getStrFromRes("Оплатить картой", "Картамен төлеу")
}

func paymentOfPurchase() -> String {
    getStrFromRes("Оплата покупки", "Сатып алу төлемі")
}

func amountOfPurchase() -> String {
    getStrFromRes("Сумма покупки", "Сатып алу сомасы")
}

func numberOfPurchase() -> String {
    getStrFromRes("Номер заказа", "Тапсырыс нөмірі")
}


func holderName() -> String {
    getStrFromRes("Имя держателя", "Ұстаушы аты")
}


func cardNumber() -> String {
    getStrFromRes("Номер карты", "Карта нөмірі")
}

func dateExpired() -> String {
    getStrFromRes("ММ/ГГ", "АА/ЖЖ")
}

func cvv() -> String {
    getStrFromRes("CVV", "CVV")
}


func saveCardData() -> String {
    getStrFromRes("Сохранить данные карты", "Карта мәліметтерін сақтаңыз")
}

func sendCheckToEmail() -> String {
    getStrFromRes("Отправить чек на e-mail", "Чекті электрондық поштаға жіберіңіз")
}


func email() -> String {
    getStrFromRes("E-mail", "E-mail")
}


func payAmount() -> String {
    getStrFromRes("Оплатить", "Төлеу")
}


func cvvInfo() -> String {
    getStrFromRes(
            "CVV находится на задней стороне вашей платежной карты",
            "CVV төлем картаңыздың артында орналасқан"
    )
}


func cardDataSaved() -> String {
    getStrFromRes("Данные карты сохранены", "Карта деректері сақталды")
}


func needFillTheField() -> String {
    getStrFromRes("Заполните поле", "Өрісті толтырыңыз")
}


func wrongDate() -> String {
    getStrFromRes("Неверная дата", "Қате күн")
}


func wrongEmail() -> String {
    getStrFromRes("Неверный емейл", "Жарамсыз электрондық пошта")
}


func wrongCvv() -> String {
    getStrFromRes("Неверный CVV", "Жарамсыз CVV")
}


func wrongCardNumber() -> String {
    getStrFromRes("Неправильный номер карты", "Карта нөмірі қате")
}


func yes() -> String {
    getStrFromRes("Да", "Иә")
}


func no() -> String {
    getStrFromRes("Нет", "Жоқ")
}


func dropPayment() -> String {
    getStrFromRes("Прервать оплату?", "Төлемді тоқтату керек пе?")
}


func paySuccess() -> String {
    getStrFromRes("Оплата прошла успешно", "Төлем сәтті болды")
}


func goToMarker() -> String {
    getStrFromRes(goToMarketRu, goToMarketKz)
}


func dropPaymentDescription() -> String {
    getStrFromRes(
            "Нажимая “Да” введенные карточные данные не будут сохранены",
            "«Иә» түймесін басу арқылы енгізілген карта деректері сақталмайды"
    )
}


func timeForPayExpired() -> String {
    getStrFromRes("Время оплаты истекло", "Төлеу уақыты аяқталды")
}


func tryFormedNewCart() -> String {
    getStrFromRes(
            "Попробуйте сформировать\nкорзину занова",
            "Себетті қайтадан\nжасап көріңіз"
    )
}


func weRepeatYourPayment() -> String {
    getStrFromRes("Повторяем ваш платеж", "Төлеміңізді қайталаймыз")
}


func thisNeedSomeTime() -> String {
    getStrFromRes("Это займет немного времени", "Бұл біраз уақытты алады")
}


func forChangeLimitInKaspi() -> String {
    getStrFromRes(
            "Для изменения лимита \nв приложении Kaspi.kz:",
            "Kaspi.kz қолданбасындағы \nшектеуді өзгерту үшін:"
    )
}


func forChangeLimitInHomebank() -> String {
    getStrFromRes(
            "Для изменения лимита \nв приложении Homebank:",
            "Homebank қолданбасындағы \nшектеуді өзгерту үшін:"
    )
}


func somethingWentWrong() -> String {
    getStrFromRes("Что-то пошло не так", "Бірдеңе дұрыс болмады")
}


func somethingWentWrongDescription() -> String {
    getStrFromRes(
            "Обратитесь в службу поддержки магазина",
            "Дүкен қолдау қызметіне хабарласыңыз"
    )
}

func orPayWithCard() -> String {
    getStrFromRes(
            "или оплатите картой",
            "немесе картамен төлеңіз"
    )
}

func payAnotherCard() -> String {
    getStrFromRes(
            payAnotherCardRu,
            payAnotherCardKz
    )
}

func accessToCardRestricted() -> String {
    getStrFromRes(
            "Доступ к сохраненным картам отменен",
            "Сақталған карталарға кіруден бас тартылды"
    )
}

func requestAccessToSavedCards() -> String {
    getStrFromRes(
            "Запрос доступа к сохраненным картам",
            "Сақталған карталарға рұқсат сұрау"
    )
}

func authenticateFingerprint() -> String {
    getStrFromRes(
            "Отсканируйте отпечаток пальца",
            "Саусақ ізін сканерлеңіз"
    )
}

func textCancel() -> String {
    getStrFromRes(
            "Отменить",
            "Бас тарту"
    )
}
