//
// Created by Mikhail Belikov on 01.09.2023.
//

import Foundation
import SwiftUI

func checkValid(
        cardNumber: String?,
        dateExpired: String?,
        cvv: String?
) -> (errorCardNumber: String?, errorDateExpired: String?, errorCvv: String?) {
    var errorCardNumber: String? = nil
    var errorDateExpired: String? = nil
    var errorCvv: String? = nil

    if (cardNumber == nil || cardNumber?.isEmpty == true) {
        errorCardNumber = needFillTheField()

    } else if (!validateCardNumWithLuhnAlgorithm(number: cardNumber) && cardNumber?.contains("•") == false) {
        errorCardNumber = wrongCardNumber()
    }

    if (dateExpired == nil || dateExpired?.isEmpty == true) {
        errorDateExpired = needFillTheField()

    } else if (!isDateValid(value: dateExpired)) {
        errorDateExpired = wrongDate()
    }

    if (cvv == nil || cvv?.isEmpty == true) {
        errorCvv = needFillTheField()

    } else if ((cvv?.count ?? 0) < 3) {
        errorCvv = wrongCvv()
    }

    return (errorCardNumber, errorDateExpired, errorCvv)
}
