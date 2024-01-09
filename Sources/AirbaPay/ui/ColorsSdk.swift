//
//  ColorsSdk.swift
//  ApayIOS
//
//  Created by Mikhail Belikov on 14.08.2023.
//

import Foundation
import SwiftUI

struct ColorsSdk {
    
    static let colorBrand = Color("ColorBrandMain", bundle: DataHolder.moduleBundle)
    static var colorBrandMain = Color("ColorBrandMain", bundle: DataHolder.moduleBundle)
    static var colorBrandInversion = Color("ColorBrandInversion", bundle: DataHolder.moduleBundle)
    
    // block
    static let bgBlock = Color("ColorBgBlock", bundle: DataHolder.moduleBundle)
    static let bgMain = Color("ColorBgMain", bundle: DataHolder.moduleBundle)
    static let bgAccent = Color("ColorBgAccent", bundle: DataHolder.moduleBundle)
    static let bgSecondaryAccent = Color("ColorBgSecondaryAccent", bundle: DataHolder.moduleBundle)
    static let bgElements = Color("ColorBgElements", bundle: DataHolder.moduleBundle)
    static let bgAPAY = Color("ColorBgAPAY", bundle: DataHolder.moduleBundle)

    // text
    static let textMain = Color("ColorTextMain", bundle: DataHolder.moduleBundle)
    static let textLight = Color("ColorTextLight", bundle: DataHolder.moduleBundle)
    static let textSecondary = Color("ColorTextSecondary", bundle: DataHolder.moduleBundle)
    static let textInversion = Color("ColorTextInversion", bundle: DataHolder.moduleBundle)
    static let textBlue = Color("ColorTextBlue", bundle: DataHolder.moduleBundle)

    // icons
    static let iconMain = Color("ColorIconMain", bundle: DataHolder.moduleBundle)
    static let iconSecondary = Color("ColorIconSecondary", bundle: DataHolder.moduleBundle)
    static let iconInversion = Color("ColorIconInversion", bundle: DataHolder.moduleBundle)

    // buttons
    static let buttonSecondaryDelete = Color("ColorButtonSecondaryDelete", bundle: DataHolder.moduleBundle)
    static let buttonDefault = Color("ColorButtonDefault", bundle: DataHolder.moduleBundle)

    // state
    static let stateSuccess = Color("ColorStateSuccess", bundle: DataHolder.moduleBundle)
    static let stateBdSuccess = Color("ColorStateBdSuccess", bundle: DataHolder.moduleBundle)
    static let stateError = Color("ColorStateError", bundle: DataHolder.moduleBundle)
    static let stateBgError = Color("ColorStateBgError", bundle: DataHolder.moduleBundle)
    static let stateWarning = Color("ColorStateWarning", bundle: DataHolder.moduleBundle)
    static let stateBgWarning = Color("ColorStateBgWarning", bundle: DataHolder.moduleBundle)

    // gray
    static let gray0 = Color("ColorGray0", bundle: DataHolder.moduleBundle)
    static let gray5 = Color("ColorGray5", bundle: DataHolder.moduleBundle)
    static let gray10 = Color("ColorGray10", bundle: DataHolder.moduleBundle)
    static let gray15 = Color("ColorGray15", bundle: DataHolder.moduleBundle)
    static let gray20 = Color("ColorGray20", bundle: DataHolder.moduleBundle)
    static let gray25 = Color("ColorGray25", bundle: DataHolder.moduleBundle)
    static let gray30 = Color("ColorGray30", bundle: DataHolder.moduleBundle)
    static let technical = Color("ColorTechnical", bundle: DataHolder.moduleBundle)

    static let transparent = Color("ColorTransparent", bundle: DataHolder.moduleBundle)
    
    
}
