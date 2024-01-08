//
//  PartialTransparentView.swift
//
//  Created by Mikhail Belikov on 21.12.2023.
//

import Foundation
import UIKit

class PartialTransparentView: UIView, RectangleCorrectProtocol {
    var rectsArray: [CGRect]?

    private var isCorrectTop: Bool = false
    private var isCorrectBottom: Bool = false
    private var isCorrectStart: Bool = false
    private var isCorrectEnd: Bool = false

    private var pointTopLeft: (CGFloat, CGFloat)? = nil
    private var pointTopRight: (CGFloat, CGFloat)? = nil
    private var pointBottomLeft: (CGFloat, CGFloat)? = nil
    private var pointBottomRight: (CGFloat, CGFloat)? = nil

    private var windowsHeight: CGFloat? = nil
    private var windowsWidth: CGFloat? = nil

    convenience init(rectsArray: [CGRect]) {
        self.init()
        RectangleCorrectHolder.observer = self
        self.rectsArray = rectsArray

        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        isOpaque = false

        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            let screenFrame = window.frame
            windowsHeight = screenFrame.height
            windowsWidth = screenFrame.width
        }
    }

    override func draw(_ rect: CGRect) {
        backgroundColor?.setFill()
        UIRectFill(rect)

        guard let rectsArray = rectsArray else {
            return
        }

        if pointTopLeft == nil || pointTopRight == nil || pointBottomLeft == nil || pointBottomRight == nil {

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
        }

        drawLine(
                startX: pointTopLeft!.0,
                startY: pointTopLeft!.1,
                endX: pointTopRight!.0,
                endY: pointTopRight!.1,
                isCorrect: isCorrectTop
        )

        drawLine(
                startX: pointTopRight!.0,
                startY: pointTopRight!.1,
                endX: pointBottomRight!.0,
                endY: pointBottomRight!.1,
                isCorrect: isCorrectEnd
        )

        drawLine(
                startX: pointBottomRight!.0,
                startY: pointBottomRight!.1,
                endX: pointBottomLeft!.0,
                endY: pointBottomLeft!.1,
                isCorrect: isCorrectBottom
        )

        drawLine(
                startX: pointBottomLeft!.0,
                startY: pointBottomLeft!.1,
                endX: pointTopLeft!.0,
                endY: pointTopLeft!.1,
                isCorrect: isCorrectStart
        )

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

    func checkPositionOfCard(
            pointTopLeft: (CGFloat, CGFloat)?,
            pointTopRight: (CGFloat, CGFloat)?,
            pointBottomLeft: (CGFloat, CGFloat)?,
            pointBottomRight: (CGFloat, CGFloat)?
    ) -> Bool {

        isCorrectTop = isCorrectVisionCoordinateToScreenCoordinateTop(point: (pointTopLeft?.1 ?? CGFloat(0.0)))
        isCorrectBottom = isCorrectVisionCoordinateToScreenCoordinateBottom(point: (pointBottomLeft?.1 ?? CGFloat(0.0)))
        isCorrectStart = isCorrectVisionCoordinateToScreenCoordinateStart(point: (pointTopLeft?.0 ?? CGFloat(0.0)))
        isCorrectEnd = isCorrectVisionCoordinateToScreenCoordinateEnd(point: (pointBottomRight?.0 ?? CGFloat(0.0)))

        self.setNeedsDisplay()

        return isCorrectTop && isCorrectBottom && isCorrectStart && isCorrectEnd
    }
}

private func isCorrectVisionCoordinateToScreenCoordinateTop(
        point: CGFloat
) -> Bool {
    let reversedVisionPoint = 1.0 - point
    return (reversedVisionPoint > 0.20) && (reversedVisionPoint <= 0.27)
}

private func isCorrectVisionCoordinateToScreenCoordinateBottom(
        point: CGFloat
) -> Bool {
    let reversedVisionPoint = 1.0 - point
    return (reversedVisionPoint > 0.50) && (reversedVisionPoint <= 0.57)
}

private func isCorrectVisionCoordinateToScreenCoordinateStart(
        point: CGFloat
) -> Bool {
    return (point > 0.11) && (point <= 0.2)
}

private func isCorrectVisionCoordinateToScreenCoordinateEnd(
        point: CGFloat
) -> Bool {
    return (point > 0.8) && (point <= 0.89)
}

