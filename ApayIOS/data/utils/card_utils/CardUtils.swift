//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation


// https://en.wikipedia.org/wiki/Payment_card_number

internal func getCardTypeFromNumber(
        input: String
) -> CardType {
    if (input.contains(try! Regex("^((34)|(37))"))) {
        return CardType.AMERICAN_EXPRESS

    } else if (input.contains(try! Regex("^(62)"))) {
        return CardType.CHINA_UNION_PAY

    } else if (input.contains(try! Regex("^(220[0–4])"))) {
        return CardType.MIR

    } else if (input.contains(try! Regex("^((5018)|(5020)|(5038)|(5893)|(6304)|(6759)|(6761)|(6762)|(6763))"))) {
        return CardType.MAESTRO

    } else if (input.contains(try! Regex("^((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))"))) {
        return CardType.MASTER_CARD

    } else if (input.contains(try! Regex("^4"))) {
        return CardType.VISA

    } else {
        return CardType.INVALID
    }
}

internal func validateCardNumWithLuhnAlgorithm(
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

        let index1 = temp.index(temp.startIndex, offsetBy: length - i)

        let indexRange = index1...index1
        let subString = temp[indexRange]

        var digit = Int(subString) ?? 0

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

