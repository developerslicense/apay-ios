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