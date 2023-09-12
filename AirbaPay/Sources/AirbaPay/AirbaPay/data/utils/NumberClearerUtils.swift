//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation

// тесты в GetNumberClearedTests
func getNumberCleared(
        amount: String?,
        isUserEntered: Bool = false,
        isPhoneNumber: Bool = false
) -> String {
    let amountLocaleCleaned = clearNumberForLocale(
            amount: amount,
            isUserEntered: isUserEntered,
            isPhoneNumber: isPhoneNumber
    )
    return clearNumberMaxSymbols(amountLocaleCleaned: amountLocaleCleaned)
}

// тесты в GetNumberClearedWithMaxSizeTests
func getNumberClearedWithMaxSymbol(
        amount: String?,
        isUserEntered: Bool = false,
        isPhoneNumber: Bool = false,
        maxSize: Int = 10
) -> String {
    let amountLocaleCleaned = clearNumberForLocale(
            amount: amount,
            isUserEntered: isUserEntered,
            isPhoneNumber: isPhoneNumber
    )
    return clearNumberMaxSymbols(
            amountLocaleCleaned: amountLocaleCleaned,
            maxSize: maxSize,
            needClearMax: true
    )
}

private func clearNumberForLocale(
        amount: String?,
        isUserEntered: Bool,
        isPhoneNumber: Bool
) -> String {
    let saved = amount ?? ""
    var amount = amount ?? ""

//    let regex = try! Regex(RegexConst.numberCleanRu) //todo нужен 16-й айос
//    let range = NSRange(location: 0, length: amount.utf16.count)
//    let regex = try! NSRegularExpression(pattern: RegexConst.numberCleanRu)

    if (isPhoneNumber) {
        if (amount.starts(with: "7 ")) {
            amount = amount.replacingOccurrences(of: "+7", with: "", options: .literal, range: nil)

            if (amount.starts(with: "7")) {
                amount = String(amount.dropFirst())
            }
        } else if (amount.starts(with: "8") || amount.contains("+7")) {
            amount = amount.replacingOccurrences(of: "+7", with: "", options: .literal, range: nil)

            if (amount.starts(with: "8")) {
                amount = String(amount.dropFirst())
            }
        }
    }

    amount = amount.filter("0123456789.,".contains)
//    amount.replace(regex, with: "")
    amount = amount.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)

    var amountLocaleCleaned = amount

    let comas = amountLocaleCleaned.split(separator: ".")

    if (comas.count > 2) {
        if (comas[1].isEmpty) {
            amountLocaleCleaned = String(comas[0]) + String(comas[2])
        } else {
            amountLocaleCleaned = String(comas[0]) + String(comas[1])
        }
    }

    if (!isUserEntered && saved.starts(with: "-")) {
        amountLocaleCleaned = "-" + amountLocaleCleaned
    }

    if (isUserEntered) {
        amountLocaleCleaned = amountLocaleCleaned.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
//        amountLocaleCleaned.replace(".", with: "")
    }

    return amountLocaleCleaned
}

private func clearNumberMaxSymbols(
        amountLocaleCleaned: String,
        maxSize: Int = 10,
        needClearMax: Bool = false
) -> String {
    let amountSplited = amountLocaleCleaned
            .split(separator: ".")
            .first?
            .split(separator: ",")

    if (needClearMax && amountSplited?[0].count ?? 0 > maxSize) {
        return String(amountSplited?[0].prefix(maxSize) ?? "")

    } else {
        return String(amountSplited?[0] ?? "")
    }
}
