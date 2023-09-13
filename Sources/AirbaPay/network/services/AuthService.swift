//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import Combine
import Alamofire

func authService(params: AuthRequest) async -> AuthResponse? {
    do {
        let data = try await NetworkManager.shared.post(
                path: "api/v1/auth/sign-in",
                parameters: params
        )

        let result: AuthResponse = try Api.parseData(data: data)
        return result

    } catch let error {
        print(error.localizedDescription)
        return nil
    }
}
