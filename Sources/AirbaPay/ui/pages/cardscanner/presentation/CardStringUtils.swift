//
//  CardStringUtils.swift
//  ios-pay_compleated-2
//
//  Created by Mikhail Belikov on 21.12.2023.
//

import Foundation

extension String {
    var isOnlyAlpha: Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }

    var isOnlyNumbers: Bool {
        return !isEmpty && range(of: "[^0-9]", options: .regularExpression) == nil
    }

    // Date Pattern MM/YY or MM/YYYY
    var isDate: Bool {
        let arrayDate = components(separatedBy: "/")
        if arrayDate.count == 2 {
            if let month = Int(arrayDate[0]) {
                return month <= 12 && month >= 1
            }
        }
        return false
    }
}
