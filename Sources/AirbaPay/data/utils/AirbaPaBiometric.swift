//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import LocalAuthentication

func airbaPayBiometricAuthenticate(
        onSuccess: @escaping () -> Void,
        onError: @escaping () -> Void
) {
    let context = LAContext()
    var error: NSError?

    // check whether biometric authentication is possible
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        // it's possible, so go ahead and use it
        let reason = "We need to unlock your data."

        context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason
        ) { success, authenticationError in
            // authentication has now completed

            if success {
                onSuccess()
            } else {
                onError()
            }
        }

    } else {
        onError()
    }
}
