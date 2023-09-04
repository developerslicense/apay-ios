//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation


// https://en.wikipedia.org/wiki/Payment_card_number

func getCardTypeFromNumber(
        input: String
) -> String {
    let range = NSRange(location: 0, length: input.utf16.count)

    let regex1 = try! NSRegularExpression(pattern: "^((34)|(37))")
    if regex1.firstMatch(in: input, options: [], range: range) != nil {
        return CardType.AMERICAN_EXPRESS
    }

    let regex2 = try! NSRegularExpression(pattern: "^((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))")
    if regex2.firstMatch(in: input, options: [], range: range) != nil {
        return CardType.MASTER_CARD
    }

    let regex3 = try! NSRegularExpression(pattern: "^4")
    if regex3.firstMatch(in: input, options: [], range: range) != nil {
        return CardType.VISA
    }

    return ""//CardType.INVALID
}

func validateCardNumWithLuhnAlgorithm(
        number: String?
) -> Bool {
    let input = getNumberCleared(amount: number)
    if ((input.count) < 16) {
        return false
    }

    var sum = 0
    let length = input.count-1

    for i in (0...length) {
        // get digits in reverse order
        let temp = String(input)
        var digit: Int = Int(getCharOnIndex(text: temp, index: i)) ?? 0

        // every 2nd number multiply with 2
        if (i % 2 == 1) {
            digit *= 2
        }

        if (digit > 9) {
            sum += digit - 9
        } else {
            sum += digit
        }
    }

    return (sum % 10 == 0)

}

