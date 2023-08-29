//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import Combine
import Alamofire

/*
protocol AuthServiceProtocol {
    func auth(params: AuthRequest) -> AnyPublisher<DataResponse<AuthResponse, NetworkError>, Never>
}

class AuthService {
    static let shared: AuthServiceProtocol = AuthService()
    private init() { }
}

extension AuthService: AuthServiceProtocol {
    func auth(params: AuthRequest) -> AnyPublisher<DataResponse<AuthResponse, NetworkError>, Never> {
        let url = URL(string: "Your_URL")!

        return AF.request(url,
                        method: .get)
                .validate()
                .publishDecodable(type: AuthResponse.self)
                .map { response in
                    response.mapError { error in
                        let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                        return NetworkError(initialError: error, backendError: backendError)
                    }
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
}*/
