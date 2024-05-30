//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import Combine
import Alamofire

func authService(params: AuthRequest) async -> AuthResponse? {
    do {
        let path = "api/v1/auth/sign-in"
        let data = try await NetworkManager.shared.post(
                path: path,
                parameters: params
        )

        let result: AuthResponse = try Api.parseData(
                data: data,
                path: path,
                method: "POST",
                bodyParams: params
        )
        DataHolder.token = result.accessToken

        return result

    } catch let error {
        print(error.localizedDescription)
        return nil
    }
}

func updateAuth(paymentId: String) async -> AuthResponse? {
    do {
        let path = "api/v1/auth/update-token/" + paymentId
        let data = try await NetworkManager.shared.put(
                path: path,
                parameters: nil
        )

        let result: AuthResponse = try Api.parseData(
                data: data,
                path: path,
                method: "PUT",
                bodyParams: nil
        )
        DataHolder.token = result.accessToken

        return result

    } catch let error {
        print(error.localizedDescription)
        return nil
    }
}
