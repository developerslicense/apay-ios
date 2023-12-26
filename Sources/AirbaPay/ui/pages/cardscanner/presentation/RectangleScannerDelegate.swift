//
//  CreditCardScannerError.swift
//
//
//  Created by josh on 2020/07/26.
//

import Foundation
import Vision
import AVFoundation
import UIKit

extension DGCardScanner {
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
                self.drawBoundingBox(rect: rect)

                self.onCaptureCardNumber(image: image)
            }
        })

        /////////        request.minimumAspectRatio = VNAspectRatio(1.3)
        /////////        request.maximumAspectRatio = VNAspectRatio(1.6)
        //////////        request.minimumSize = Float(0.5)
        /////////        request.maximumObservations = 1
        detectRectanglesRequest.minimumAspectRatio = VNAspectRatio(0.3)
        detectRectanglesRequest.maximumAspectRatio = VNAspectRatio(0.9)
        detectRectanglesRequest.minimumSize = Float(0.4)
        detectRectanglesRequest.maximumObservations = 0
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
                //                self.presentAlert("Image Request Failed", error: error)
                return
            }
        }
    }

    private func drawBoundingBox(rect: VNRectangleObservation) {

        CATransaction.begin()

        let transform = CGAffineTransform(scaleX: 1, y: -1)
                .translatedBy(x: 0, y: -previewLayer.bounds.height)

        let scale = CGAffineTransform.identity
                .scaledBy(x: previewLayer.bounds.width,
                        y: previewLayer.bounds.height)

        let currentBounds = rect.boundingBox
                .applying(scale).applying(transform)

        createLayer(in: currentBounds)

        CATransaction.commit()

        /////////////////viewModel.cameraDetectRectFrame = currentBounds
    }

    private func createLayer(in rect: CGRect) {
        maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.opacity = 1
        maskLayer.borderColor = UIColor.blue.cgColor ///for visual test
        maskLayer.borderWidth = 2
        previewLayer.insertSublayer(maskLayer, at: 1)
    }
}

extension CGPoint {
    private func scaled(to size: CGSize) -> CGPoint {
        return CGPoint(x: self.x * size.width,
                y: self.y * size.height)
    }
}
