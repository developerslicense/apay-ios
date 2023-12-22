//
//  PartialTransparentView.swift
//  ios-pay_compleated-2
//
//  Created by Mikhail Belikov on 21.12.2023.
//

import Foundation
import UIKit

class PartialTransparentView: UIView {
    var rectsArray: [CGRect]?

    convenience init(rectsArray: [CGRect]) {
        self.init()

        self.rectsArray = rectsArray

        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        isOpaque = false
    }

    override func draw(_ rect: CGRect) {
        backgroundColor?.setFill()
        UIRectFill(rect)

        guard let rectsArray = rectsArray else {
            return
        }

        for holeRect in rectsArray {
            let path = UIBezierPath(roundedRect: holeRect, cornerRadius: 10)

            let holeRectIntersection = rect.intersection(holeRect)

            UIRectFill(holeRectIntersection)

            UIColor.clear.setFill()
            UIGraphicsGetCurrentContext()?.setBlendMode(CGBlendMode.copy)
            path.fill()
        }
    }
}
