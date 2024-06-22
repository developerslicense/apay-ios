//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation

// тесты в CardDateTest
func isDateValid(
        value: String?
) -> Bool {

    if (value?.isEmpty == true
            || value == nil
            || value?.starts(with: "00") ?? true
       ) {
        return false
    }

    var year: Int
    var month: Int
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value?.contains("/") == true && (value?.count ?? 0) == 5) {

        let split = value!.split(separator: "/")
        // The value before the slash is the month while the value to right of
        // it is the year.
        month = Int(split[0]) ?? 0
        year = Int(split[1]) ?? 0

    } else { // Only the month was entered

        month = Int(value?.prefix(value?.count ?? 0) ?? "0") ?? 0
        year = -1 // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
        // A valid month is between 1 (January) and 12 (December)
        return false
    }

    let date = Date()
    var fourDigitsYear = 0
    if (year < 2000) {
        fourDigitsYear = 2000 + year
    } else {
        fourDigitsYear = year
    }

    let nowYear = Int(getYear(date: date))
    let nowMonth = Int(getMonth(date: date))

    if ((fourDigitsYear < 2010) || (fourDigitsYear > 2099)) {

        // We are assuming a valid year should be between 1 and 2099.
        // Note that, it"s valid doesn"t mean that it has not expired.
        return false
    }

    if (fourDigitsYear > nowYear ?? 0) {
        return true

    } else {
        return fourDigitsYear == nowYear
                && month >= nowMonth ?? 1
    }

}


private func getYear(
        date: Date
) -> String {
    let dateFormat = DateFormatter() //"yyyy", Locale("ru"))
    dateFormat.dateFormat = "yyyy"
    return dateFormat.string(from: date)
}

private func getMonth(
        date: Date
) -> String {
    let dateFormat = DateFormatter() //"MM", Locale("ru"))
    dateFormat.dateFormat = "MM"
    return dateFormat.string(from: date)

}
