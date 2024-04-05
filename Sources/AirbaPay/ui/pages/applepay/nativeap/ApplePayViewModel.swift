//
//  ApplePayViewModel.swift
//
//  Created by Mikhail Belikov on 05.04.2024.
//

import Foundation

class ApplePayViewModel {
    
    func auth(
        onError: @escaping () -> Void,
        onSuccess: @escaping () -> Void
    ) {
           let params = AuthRequest(
                password: DataHolder.password,
                paymentId: nil,
                terminalId: DataHolder.terminalId,
                user: DataHolder.shopId
           )

           Task {
               if let resultAuth = await authService(params: params) {
                   DataHolder.accessToken = resultAuth.accessToken
                   
                   if let resultCreatePayment = await createPaymentService() {
                       let params = AuthRequest(
                           password: DataHolder.password,
                           paymentId: resultCreatePayment.id,
                           terminalId: DataHolder.terminalId,
                           user: DataHolder.shopId
                       )
                       
                       if let result = await authService(params: params) {
                            onSuccess()
                       } else {
                           onError()
                       }
                       
                   } else {
                       onError()
                   }
               } else {
                   onError()
               }
           }
       }

       func processingWallet(
            navigateCoordinator: AirbaPayCoordinator,
            applePayToken: String
       ) {

           Task {
               if let result = await putPaymentWallet(applePayToken: applePayToken/*.base64Encoded()*/) {
                   if result.errorCode != 0 {
                       let error = ErrorsCode(code: result.errorCode ?? 1).getError()
                       navigateCoordinator.openErrorPageWithCondition(errorCode: error.code)

                   } else if result.isSecure3D == true {
                       navigateCoordinator.openAcquiring(
                            redirectUrl: result.secure3D?.action
                       )

                   } else {
                       navigateCoordinator.openSuccess()
                   }
                   
               } else {
                   navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)
               }
           }
       }
}
