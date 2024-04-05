//
//  ApplePayManager.swift
//
//  Created by Mikhail Belikov on 04.04.2024.
//

import Foundation
import PassKit

final class ApplePayManager: NSObject {// todo нужно вызвать то, что у гугл было для нативки

    var applePayViewModel: ApplePayViewModel = ApplePayViewModel()
    var navigateCoordinator: AirbaPayCoordinator
    var isSuccess: Bool = false
    var redirect3dsUrl: String? = nil
    var applePayToken: String? = nil

    init(
            navigateCoordinator: AirbaPayCoordinator
    ) {
        self.navigateCoordinator = navigateCoordinator
    }

    private lazy var paymentRequest: PKPaymentRequest = {
        let request: PKPaymentRequest = PKPaymentRequest()
        let merchandId = DataHolder.isProd ? "merchant.kz.airbapay.pf" : "merchant.kz.airbapay.spf" // todo ???
        //label here can be passed in as a variable like we do itemCost and shippingCost.
        let summary = PKPaymentSummaryItem(label: DataHolder.shopName, amount: NSDecimalNumber(integerLiteral: Int(DataHolder.purchaseAmount)!))

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

    var btnApplePay: PKPaymentButton = {
        let btn: PKPaymentButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
        btn.cornerRadius = 10
        //btn.addTarget(self, action: #selector(buyBtnTapped), for: .touchUpInside)
        return btn
    }()

    func buyBtnTapped() {
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

    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)

        if isSuccess {
            self.applePayViewModel.processingWallet(
                    navigateCoordinator: self.navigateCoordinator,
                    applePayToken: self.applePayToken ?? ""
            )


        } else {
            navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_5007.code)

        }
    }

    func paymentAuthorizationViewController(
            _ controller: PKPaymentAuthorizationViewController,
            didAuthorizePayment payment: PKPayment,
            handler completion: @escaping (PKPaymentAuthorizationResult) -> Void
    ) {

        applePayViewModel.auth(
                onError: {
                    self.isSuccess = false
                    completion(.init(status: .failure, errors: nil))
                },
                onSuccess: {
                    self.isSuccess = true
                    self.applePayToken = String(data: payment.token.paymentData, encoding: .utf8)!
                    completion(.init(status: .success, errors: nil))
                }
        )
    }

    func paymentAuthorizationViewController(
            _ controller: PKPaymentAuthorizationViewController,
            didSelectShippingContact contact: PKContact,
            handler completion: @escaping (PKPaymentRequestShippingContactUpdate) -> Void
    ) {

        completion(.init(paymentSummaryItems: [PKPaymentSummaryItem(label: "ios", amount: NSDecimalNumber(value: Int(DataHolder.purchaseAmount)!) )]))
    }

}

