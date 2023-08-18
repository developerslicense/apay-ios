//
// Created by Mikhail Belikov on 16.08.2023.
//

import Foundation

func getStrFromRes(_ ru: String, _ kz: String)-> String {
    if (DataHolder.currentLang == AirbaPaySdk.Lang.KZ()) {
        return kz
    } else {
        return ru
    }
}

func getCharOnIndex(
    text: String,
    index: Int
)-> String {
    let length = text.count - 1
    let index1 = text.index(text.startIndex, offsetBy: length - index)

    let indexRange = index1...index1
    let subString = text[indexRange]

    return String(subString)
}