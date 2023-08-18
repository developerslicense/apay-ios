//
// Created by Mikhail Belikov on 16.08.2023.
//

import Foundation

internal class RegexConst {
    static let NON_BREAK_SPACE = " "
    static let NOT_DIGITS_NOT_COMMA_NOT_NON_BREAK_SPACE = "[^, 0-9]+"
    static let NOT_DIGITS = "[\\D]"
    static let DIGITS = "\\b([0-9]+)"
    static let CARD = "\\b([0-9] )"
    static let TEXTS = "[a-zA-Z -]"
    static let numberCleanEn = "[^0-9.]"
    static let numberCleanRu = "[^0-9,.]"
    static let emailValidation = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"
}
