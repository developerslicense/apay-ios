//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation


// тесты в MoneyTests

struct Money {

    var amount: Int = 0
    var currency: String = kzt

    func getFormatted() -> String {
        getMoneyFormatted(amount: String(amount))
    }


    static func initString(
            amount: String,
            currency: String = kzt
    ) -> Money {
        return Money(
                amount: Int(getNumberClearedWithMaxSymbol(amount: amount)) ?? 0,
                currency: currency
        )
    }

    static func initInt(
            amount: Int,
            currency: String = kzt
    ) -> Money {
        return Money(
                amount: Int(getNumberClearedWithMaxSymbol(amount: String(amount))) ?? 0,
                currency: currency
        )
    }

    static func initDouble(
            amount: Double,
            currency: String = kzt
    ) -> Money {
        return Money(
                amount: Int(getNumberClearedWithMaxSymbol(amount: String(Int(amount)))) ?? 0,
                currency: currency
        )
    }


    static func initMoney(amount: Money) -> Money {
        return Money(
                amount: Int(getNumberClearedWithMaxSymbol(amount: String(amount.amount))) ?? 0,
                currency: amount.currency
        )
    }
}

func getMoneyFormatted(
        amount: String,
        currency: String = kzt
) -> String {
    let format = NumberFormatter()
    format.locale = Locale(identifier: "kk_Cyrl_KZ")
    format.numberStyle = .currency
    format.maximumFractionDigits = 0 // отключил десятичные. было значение 2

    var tempAmount = getNumberClearedWithMaxSymbol(amount: amount)
    while (tempAmount.starts(with: "0")) {
        tempAmount = String(tempAmount.dropFirst())
    }

    return format.string(from: NSNumber(value: Int(tempAmount) ?? 0)) ?? "0"
}

