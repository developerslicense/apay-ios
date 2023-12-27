//
//  CardScannerDelegate.swift
//
//  Created by Mikhail Belikov on 22.12.2023.
//

import Foundation
import AVFoundation
import UIKit
import Vision

extension DGCardScannerViewController {

    func onCaptureCardNumber(image: CVPixelBuffer) {

        DispatchQueue.global(qos: .userInitiated).async {
            self.extractPaymentCardData(frame: image)
        }
    }

    private func extractPaymentCardData(frame: CVImageBuffer) {
        let ciImage = CIImage(cvImageBuffer: frame)

        let resizeFilter = CIFilter(name: "CILanczosScaleTransform")!

        // Desired output size
        let targetSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        // Compute scale and corrective aspect ratio
        let scale = targetSize.height / ciImage.extent.height
        let aspectRatio = targetSize.width / (ciImage.extent.width * scale)

        // Apply resizing
        resizeFilter.setValue(ciImage, forKey: kCIInputImageKey)
        resizeFilter.setValue(scale, forKey: kCIInputScaleKey)
        resizeFilter.setValue(aspectRatio, forKey: kCIInputAspectRatioKey)
        let outputImage = resizeFilter.outputImage

        //        let croppedImage = outputImage!.cropped(to: CGRect(x: viewX, y: viewY, width: widht, height: height))

        let request = VNRecognizeTextRequest()
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = false

        let stillImageRequestHandler = VNImageRequestHandler(ciImage: outputImage!, options: [:])
        //        let stillImageRequestHandler = VNImageRequestHandler(ciImage: croppedImage, options: [:])
        try? stillImageRequestHandler.perform([request])

        guard let texts = request.results, texts.count > 0 else {
            // no text detected
            return
        }

        let arrayLines = texts.flatMap({ $0.topCandidates(200).map({ $0.string }) })

        for line in arrayLines {

            let number = getNumberCleared(amount: line)
            let isValid = validateCardNumWithLuhnAlgorithm(number: number)

            if isValid {
                scanCompleted(creditCardNumber: number, creditCardDate: "", creditCardName: "")
            }
        }
    }
}


