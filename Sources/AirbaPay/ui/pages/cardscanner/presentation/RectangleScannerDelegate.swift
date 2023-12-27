//
//  RectangleScannerDelegate.swift
//
//

import Foundation
import Vision
import AVFoundation
import UIKit

protocol RectangleCorrectProtocol {
    func isCorrect(
            isCorrectVertical: Bool,
            isCorrectHorizontal: Bool
    )
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

                let topLeftY = roundNumberTo(number: rect.topLeft.y)
                let topLeftX = roundNumberTo(number: rect.topLeft.x)

                let bottomLeftX = roundNumberTo(number: rect.bottomLeft.x)
                let topRightY = roundNumberTo(number: rect.topRight.y)

                RectangleCorrectHolder.observer?.isCorrect(
                        isCorrectVertical: topLeftY == topRightY,
                        isCorrectHorizontal: topLeftX == bottomLeftX
                )

                if topLeftY == topRightY && topLeftX == bottomLeftX {
                    self.onCaptureCardNumber(image: image)
                }
            }
        })

        detectRectanglesRequest.minimumAspectRatio = VNAspectRatio(0.3)
        detectRectanglesRequest.maximumAspectRatio = VNAspectRatio(0.7)
        detectRectanglesRequest.minimumSize = Float(0.4)
        detectRectanglesRequest.maximumObservations = 1//0
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
}

extension CGPoint {
    private func scaled(to size: CGSize) -> CGPoint {
        return CGPoint(x: self.x * size.width,
                y: self.y * size.height)
    }
}
