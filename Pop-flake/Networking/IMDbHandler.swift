//
//  IMDbHandler.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 05/08/2022.
//

import Foundation

class IMDbHandler {
    let apiKey: String
    init(key apiKey: String) {
        self.apiKey = apiKey
    }
    func fetchResponse<IMDbModelType: IMDbModelProtocol>(endPoint: IMDbEndPoint, method: HTTPMethod) async throws -> IMDbModelType {
        var model: IMDbModelType
        guard let targetURL = endPoint.targetURL(with: apiKey) else {
            throw IMDbErrorHandler.badURL
        }
        var request = URLRequest(url: targetURL)
        request.httpMethod = method.rawValue
        let (data, response) = try await URLSession.shared.data(for: request)

//        let string = String(data: data, encoding: .utf8)
//        print(string)

        guard let response = response as? HTTPURLResponse else {
            throw IMDbErrorHandler.noResponse
        }
        if (200...299).contains(response.statusCode) == false {
            throw IMDbErrorHandler.badResponse(response.statusCode)
        }
        do {
            model = try JSONDecoder().decode(IMDbModelType.self, from: data)
        } catch {
            throw IMDbErrorHandler.jsonDecodingError
        }
        if !(model.errorMessage.isEmpty) {
            throw IMDbErrorHandler.IMDbAPIError(model.errorMessage)
        }
        return model
    }
}
