//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation


// тесты в MoneyTests

internal struct Money {

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
                amount: amount,
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

internal func getMoneyFormatted(
        amount: String,
        currency: String = "KZT"
) -> String {
    let format = NumberFormatter()
    format.locale = Locale(identifier: "kk_Cyrl_KZ")
    format.numberStyle = .currency
    format.maximumFractionDigits = 0 // отключил десятичные. было значение 2

    var tempAmount = getNumberClearedWithMaxSymbol(amount: amount)

    while (tempAmount.starts(with: "0")) {
        tempAmount = String(tempAmount.dropFirst())
    }

    let amountNumberFormatted = format.string(from: NSNumber(value: Int(amount) ?? 0)) ?? "0"
    return replaceCurrencyIso4217(amount: amountNumberFormatted, currency: currency)
}

private func replaceCurrencyIso4217(
        amount: String,
        currency: String?
) -> String {
    var amount = amount

    if (currency != nil) {
        let cur = (currency ?? "") + " "
        amount.replace(cur, with: "")
        amount = amount + " " + kzt

    } else {
        do {
            let regex = try! Regex(RegexConst.NOT_DIGITS_NOT_COMMA_NOT_NON_BREAK_SPACE)
            if let match = amount.wholeMatch(of: regex) {
                amount = match.last?.name ?? ""// https://useyourloaf.com/blog/getting-started-with-swift-regex/
            }

        } catch {
            print("replaceCurrencyIso4217 error")
        }
    }

    return amount
}