//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation
import Alamofire

internal struct NetworkError: Error {
    let initialError: AFError
    let backendError: BackendError?
}

internal struct BackendError: Codable, Error {
    var status: String
    var message: String
}