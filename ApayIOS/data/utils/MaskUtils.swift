//
// Created by Mikhail Belikov on 17.08.2023.
//

import Foundation

class MaskUtils {
    var pattern: String = ""
    var isDateExpiredMask: Bool = false
    var patternArr: [String] = []

    func getNextCursorPosition(newPosition: Int) -> Int {
        if (pattern.suffix(newPosition) != "A") {
            var tempPosition = newPosition + 1
            while (pattern.suffix(tempPosition) != "A") {
                tempPosition += 1
            }

            return tempPosition
        } else {
            return newPosition
        }
    }

    func format(
            text: String,
            optionForTest: Bool = false
    ) -> String {
        var textArr: [String] = []
        var textI = 0

        if (optionForTest) {
            patternArr = []
        }

        if (patternArr.isEmpty
                || optionForTest) {
            let temp = pattern.split(separator: "")
            for ch in temp {
                patternArr.append(String(ch))
            }
        }

        if (isDateExpiredMask
                && !text.isEmpty
                && text != " "
                && text.first != "1"
                && text.first != "0") {

            textArr.append("0")
        }

        let temp = text.split(separator: "")
        for ch in temp {
            textArr.append(String(ch))
        }

        for patternI in (0...patternArr.count) {
            if (patternArr[patternI] == "A" && textI < textArr.count) {
                textI = textI + 1
                patternArr[patternI] = textArr[textI]

            } else {
                continue
            }
        }

        var sb:[String] = [""]
        for it in patternArr {
            var it1 = it
            it1.replace("A", with: "")
            sb.append(it1)
        }

        return sb.joined()
    }
}