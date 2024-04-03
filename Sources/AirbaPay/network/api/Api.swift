//
// Created by Mikhail Belikov on 29.08.2023.
//

import Foundation

class Api {

    static func parseDataLoggly<T: Decodable>(data: Data) throws -> T{
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
        else {
            throw NSError(
                    domain: "NetworkAPIError",
                    code: 3,
                    userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
            )
        }

        return decodedData
    }

    static func parseData<T: Decodable>(
            data: Data,
            path: String,
            method: String,
            bodyParams: (any Encodable)? = nil

    ) throws -> T{
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
        else {
            Logger.log(
                    message: "JSON decode error",
                    url: path,
                    method: method,
                    bodyParams: bodyParams,
                    response: data
            )
            throw NSError(
                    domain: "NetworkAPIError",
                    code: 3,
                    userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
            )
        }

        Logger.log(
                url: path,
                method: method,
                bodyParams: bodyParams,
                response: data
        )

        return decodedData
    }
}
