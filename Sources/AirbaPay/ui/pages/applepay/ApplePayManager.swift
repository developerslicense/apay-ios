//
//  ApplePayManager.swift
//
//  Created by Mikhail Belikov on 04.04.2024.
//

import Foundation
import PassKit

final class ApplePayManager: NSObject {

    var applePayViewModel: ApplePayViewModel = ApplePayViewModel()
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
            let summary = PKPaymentSummaryItem(label: DataHolder.shopName, amount: NSDecimalNumber(string: DataHolder.purchaseAmount))

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

        if let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
            paymentVC.delegate = self
//            navigateCoordinator.present(paymentVC, animated: true)

            if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
                if window.rootViewController == nil {
                    window.rootViewController = UINavigationController(rootViewController: navigateCoordinator)
                }
                navigateCoordinator.present(paymentVC, animated: true)
            }

        } else {
            return
        }
    }
}

// MARK: - PKPaymentAuthorizationViewControllerDelegate
extension ApplePayManager: PKPaymentAuthorizationViewControllerDelegate {

    public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)

        if isSuccess {
            self.applePayViewModel.processingWallet(
                    navigateCoordinator: self.navigateCoordinator,
                    applePayToken: self.applePayToken ?? ""
            )
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

