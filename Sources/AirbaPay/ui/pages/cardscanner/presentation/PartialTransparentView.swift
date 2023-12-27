//
//  PartialTransparentView.swift
//
//  Created by Mikhail Belikov on 21.12.2023.
//

import Foundation
import UIKit

class PartialTransparentView: UIView, RectangleCorrectProtocol {
    var rectsArray: [CGRect]?

    private var isHorizontalCorrect: Bool = false
    private var isVerticalCorrect: Bool = false

    convenience init(rectsArray: [CGRect]) {
        self.init()
        RectangleCorrectHolder.observer = self
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

        var pointTopLeft: (CGFloat, CGFloat)? = nil
        var pointTopRight: (CGFloat, CGFloat)? = nil
        var pointBottomLeft: (CGFloat, CGFloat)? = nil
        var pointBottomRight: (CGFloat, CGFloat)? = nil


        for holeRect in rectsArray {
            let path = UIBezierPath(roundedRect: holeRect, cornerRadius: 10)

            UIColor.clear.setFill()

            pointTopLeft = (path.cgPath.boundingBoxOfPath.minX, path.cgPath.boundingBoxOfPath.minY)
            pointBottomLeft = (path.cgPath.boundingBoxOfPath.minX, path.cgPath.boundingBoxOfPath.maxY)

            pointTopRight = (path.cgPath.boundingBoxOfPath.maxX, path.cgPath.boundingBoxOfPath.minY)
            pointBottomRight = (path.cgPath.boundingBoxOfPath.maxX, path.cgPath.boundingBoxOfPath.maxY)

            UIGraphicsGetCurrentContext()?.setBlendMode(CGBlendMode.copy)
            path.fill()
        }

        drawLine(startX: pointTopLeft!.0, startY: pointTopLeft!.1, endX: pointTopRight!.0, endY: pointTopRight!.1, isCorrect: isHorizontalCorrect)
        drawLine(startX: pointTopRight!.0, startY: pointTopRight!.1, endX: pointBottomRight!.0, endY: pointBottomRight!.1, isCorrect: isVerticalCorrect)
        drawLine(startX: pointBottomRight!.0, startY: pointBottomRight!.1, endX: pointBottomLeft!.0, endY: pointBottomLeft!.1, isCorrect: isHorizontalCorrect)
        drawLine(startX: pointBottomLeft!.0, startY: pointBottomLeft!.1, endX: pointTopLeft!.0, endY: pointTopLeft!.1, isCorrect: isVerticalCorrect)

    }

    private func drawLine(
            startX: CGFloat,
            startY: CGFloat,
            endX: CGFloat,
            endY: CGFloat,
            isCorrect: Bool
    ) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(4.0)
        context?.setStrokeColor(isCorrect ? UIColor.green.cgColor : UIColor.red.cgColor)
        context?.move(to: CGPoint(x: startX, y: startY))
        context?.addLine(to: CGPoint(x: endX, y: endY))
        context?.strokePath()
    }

    func isCorrect(
            isCorrectVertical: Bool,
            isCorrectHorizontal: Bool
    ) {
        self.isHorizontalCorrect = isCorrectHorizontal
        self.isVerticalCorrect = isCorrectVertical
        self.setNeedsDisplay()

    }

}


