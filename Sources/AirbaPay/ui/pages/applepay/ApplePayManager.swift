//
//  ApplePayManager.swift
//
//  Created by Mikhail Belikov on 04.04.2024.
//

import Foundation
import PassKit
import UIKit

final class ApplePayManager: NSObject {

    var navigateCoordinator: AirbaPayCoordinator
    var isSuccess: Bool = false
    var redirect3dsUrl: String? = nil
    var applePayToken: String? = nil

    init(navigateCoordinator: AirbaPayCoordinator) {
        self.navigateCoordinator = navigateCoordinator
    }

    func buyBtnTapped() {
        let paymentRequest: PKPaymentRequest = {
            let request: PKPaymentRequest = PKPaymentRequest()
            let merchandId = DataHolder.applePayMerchantId!
            //label here can be passed in as a variable like we do itemCost and shippingCost.
            let summary = PKPaymentSummaryItem(label: DataHolder.shopName, amount: NSDecimalNumber(string: String(DataHolder.purchaseAmount)))

            //        shippingMethod.identifier = "ios App"
            request.merchantIdentifier = merchandId
            request.countryCode = "KZ"
            request.currencyCode = "KZT"
            request.merchantCapabilities = .capability3DS//PKMerchantCapability([.capability3DS, .capabilityCredit, .capabilityDebit, .capabilityEMV])
            request.paymentSummaryItems = [summary]
            request.shippingType = .servicePickup
            request.supportedCountries = ["KZ"]
            request.supportedNetworks = [.maestro, .masterCard, .quicPay, .visa, .vPay]

            return request
        }()


        guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest),
              let window = UIApplication.shared.connectedScenes
                      .filter({$0.activationState == .foregroundActive})
                      .map({$0 as? UIWindowScene})
                      .compactMap({$0})
                      .first?.windows
                      .filter({$0.isKeyWindow}).first
        else {
            return

        }
        paymentVC.delegate = self
        window.rootViewController?.present(paymentVC, animated: true, completion: nil)
    }
}

// MARK: - PKPaymentAuthorizationViewControllerDelegate
extension ApplePayManager: PKPaymentAuthorizationViewControllerDelegate {

    public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)

        if isSuccess {
            AirbaPaySdk.sdk?.processExternalApplePay(applePayToken: self.applePayToken ?? "")
        }
    }

    public func paymentAuthorizationViewController(
            _ controller: PKPaymentAuthorizationViewController,
            didAuthorizePayment payment: PKPayment,
            handler completion: @escaping (PKPaymentAuthorizationResult) -> Void
    ) {
        self.isSuccess = true
        self.applePayToken = String(data: payment.token.paymentData, encoding: .utf8)!
        completion(.init(status: .success, errors: nil))

    }
}

