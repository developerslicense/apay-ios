//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import Alamofire

actor NetworkManager: GlobalActor {
    static let shared = NetworkManager()

    private init() {
    }

    private let maxWaitTime = 300.0

    func get(path: String, parameters: Parameters?) async throws -> Data {
        try await executeRequestParameters(method: .get, path: path, parameters: parameters)
    }

    func delete(path: String, parameters: Parameters?) async throws -> Data {
        try await executeRequestParameters(method: .delete, path: path, parameters: parameters)
    }

    func put(path: String, parameters: Encodable?) async throws -> Data {
        if (parameters == nil) {
            return try await executeRequestParameters(method: .put, path: path, parameters: nil)
        } else {
            return try await executeRequestEncodable(method: .put, path: path, parameters: parameters!)
        }
    }

    func post(path: String, parameters: Encodable) async throws -> Data {
        try await executeRequestEncodable(method: .post, path: path, parameters: parameters)
    }

    func postLoggly(path: String, parameters: Encodable) async throws -> Data {
        try await executeRequestLoggly(path: path, parameters: parameters)
    }

    private func executeRequestLoggly(
            path: String,
            parameters: Encodable
    ) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in

            AF.request(
                            LOGGLY_API_URL + path,
                            method: .post,
                            parameters: parameters,
                            encoder: JSONParameterEncoder.default,
                            headers: [
                                "Content-Type": "application/json; charset=utf-8"
                            ],
                            requestModifier: { $0.timeoutInterval = self.maxWaitTime }
                    )
                    .responseData { response in
//                        if (!DataHolder.isProd || DataHolder.enabledLogsForProd) {
//                            print("AirbaPayLoggly ")
//                            print(parameters)
//                            print(response.debugDescription)
//                        }

                        switch (response.result) {
                        case let .success(data):
                            continuation.resume(returning: data)
                        case let .failure(error):
                            continuation.resume(throwing: self.handleError(error: error))
                        }
                    }

        }
    }

    private func executeRequestEncodable(
            method: HTTPMethod,
            path: String,
            parameters: Encodable
    ) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            AF.request(
                            DataHolder.baseUrl + path,
                            method: method,
                            parameters: parameters,
                            encoder: JSONParameterEncoder.default,
                            headers: [
                                "Content-Type": "application/json; charset=utf-8",
                                "Platform": "iOS, " + DataHolder.sdkVersion,
                                "Authorization":
                                DataHolder.token == nil
                                        || DataHolder.token == "" ? "" : "Bearer " + DataHolder.token!
                            ],
                            requestModifier: { $0.timeoutInterval = self.maxWaitTime }
                    )
                    .responseData { response in
                        if (!DataHolder.isProd || DataHolder.enabledLogsForProd) {
                            print("AirbaPay ")
                            print(parameters)
                            print(response.debugDescription)
                        }

                        switch (response.result) {
                        case let .success(data):
                            continuation.resume(returning: data)
                        case let .failure(error):
                            continuation.resume(throwing: self.handleError(error: error))
                        }
                    }
        }
    }

    private func executeRequestParameters(
            method: HTTPMethod,
            path: String,
            parameters: Parameters?
    ) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            AF.request(
                            DataHolder.baseUrl + path,
                            method: method,
                            parameters: parameters,

                            headers: [
                                "Content-Type": "application/json; charset=utf-8",
                                "Platform": "iOS, " + DataHolder.sdkVersion,
                                "Authorization":
                                DataHolder.token == nil
                                        || DataHolder.token == "" ? "" : "Bearer " + DataHolder.token!
                            ],
                            requestModifier: { $0.timeoutInterval = self.maxWaitTime }
                    )
                    .responseData { response in
                        if (!DataHolder.isProd || DataHolder.enabledLogsForProd) {
                            print("AirbaPay ")
                            print(parameters)
                            print(response.debugDescription)
                        }

                        switch (response.result) {
                        case let .success(data):
                            continuation.resume(returning: data)
                        case let .failure(error):
                            continuation.resume(throwing: self.handleError(error: error))
                        }
                    }
        }
    }

    private func handleError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code

            if code == NSURLErrorNotConnectedToInternet ||
                       code == NSURLErrorTimedOut ||
                       code == NSURLErrorInternationalRoamingOff ||
                       code == NSURLErrorDataNotAllowed ||
                       code == NSURLErrorCannotFindHost ||
                       code == NSURLErrorCannotConnectToHost ||
                       code == NSURLErrorNetworkConnectionLost {

                var userInfo = nserror.userInfo

                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"

                let currentError = NSError(
                        domain: nserror.domain,
                        code: code,
                        userInfo: userInfo
                )

                return currentError
            }
        }
        return error
    }
}
