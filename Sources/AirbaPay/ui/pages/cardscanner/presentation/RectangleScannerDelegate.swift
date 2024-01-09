//
//  RectangleScannerDelegate.swift
//
//

import Foundation
import Vision
import AVFoundation
import UIKit

protocol RectangleCorrectProtocol {
    func checkPositionOfCard(
            pointTopLeft: (CGFloat, CGFloat)?,
            pointTopRight: (CGFloat, CGFloat)?,
            pointBottomLeft: (CGFloat, CGFloat)?,
            pointBottomRight: (CGFloat, CGFloat)?
    ) -> Bool
}

class RectangleCorrectHolder {
    static var observer: RectangleCorrectProtocol? = nil
}

extension DGCardScannerViewController {
    func onCaptureRectangle(sampleBuffer: CMSampleBuffer) {
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            debugPrint("unable to get image from sample buffer")
            return
        }
        detectRectangle(in: frame)
    }

    private func detectRectangle(in image: CVPixelBuffer) {
        let detectRectanglesRequest = VNDetectRectanglesRequest(completionHandler: { (request: VNRequest, error: Error?) in
            DispatchQueue.main.async {
                guard let results = request.results as? [VNRectangleObservation] else {

                    return
                }

                self.maskLayer.removeFromSuperlayer()
                guard let rect = results.first else {
                    return
                }

                let isCorrect = RectangleCorrectHolder.observer?.checkPositionOfCard(
                        pointTopLeft: (rect.topLeft.x, rect.topLeft.y),
                        pointTopRight: (rect.topRight.x, rect.topRight.y),
                        pointBottomLeft: (rect.bottomLeft.x, rect.bottomLeft.y),
                        pointBottomRight: (rect.bottomRight.x, rect.bottomRight.y)
                ) ?? false

//                self.drawBoundingBox(rect: rect) // для визуального тестирования положения карты

                if isCorrect {
                    self.onCaptureCardNumber(image: image)
                }

            }
        })

        detectRectanglesRequest.minimumAspectRatio = VNAspectRatio(0.3)
        detectRectanglesRequest.maximumAspectRatio = VNAspectRatio(0.7)
        detectRectanglesRequest.minimumSize = Float(0.4)
        detectRectanglesRequest.maximumObservations = 1
        detectRectanglesRequest.minimumConfidence = 0.2
        detectRectanglesRequest.quadratureTolerance = 2
        detectRectanglesRequest.revision = VNDetectRectanglesRequestRevision1
        detectRectanglesRequest.preferBackgroundProcessing = true


        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, options: [:])

        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try imageRequestHandler.perform([detectRectanglesRequest])
            } catch let error as NSError {
                print("Failed to perform image request: \(error)")
                return
            }
        }
    }

    private func drawBoundingBox(rect: VNRectangleObservation) { // для визуального тестирования положения карты

        CATransaction.begin()

        let points = [rect.topLeft, rect.topRight, rect.bottomRight, rect.bottomLeft]
        let convertedPoints = points.map {
            CGPoint(x: $0.x * self.view.frame.width, y: (1 - $0.y) * self.view.frame.height)
        }
        self.maskLayer = self.drawBoundingBox(convertedPoints)
        self.view.layer.addSublayer(self.maskLayer)

        CATransaction.commit()

    }

    private func drawBoundingBox(_ points: [CGPoint]) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.fillColor = #colorLiteral(red: 0.4506933627, green: 0.5190293554, blue: 0.9686274529, alpha: 0.2050513699)
        layer.strokeColor = #colorLiteral(red: 0.3328347607, green: 0.236689759, blue: 1, alpha: 1)
        layer.lineWidth = 2
        let path = UIBezierPath()
        path.move(to: points.last!)
        points.forEach { point in
            path.addLine(to: point)
        }
        layer.path = path.cgPath
        return layer
    }
}

extension CGPoint {
    private func scaled(to size: CGSize) -> CGPoint {
        return CGPoint(x: self.x * size.width,
                y: self.y * size.height)
    }
}
