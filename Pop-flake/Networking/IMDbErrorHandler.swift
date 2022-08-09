//
//  IMDbErrorHandler.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 06/08/2022.
//

import UIKit

enum IMDbErrorHandler: Error {
    case badURL
    case noResponse
    case badResponse(Int)
    case jsonDecodingError
    case IMDbAPIError(String)
    var alertView: UIAlertController {
        var errorTitle: String
        var errorMessage: String
        switch self {
        case .badURL:
            errorTitle = "Bad URL"
            errorMessage = "Bad URL"
        case .noResponse:
            errorTitle = "No response from server"
            errorMessage = "Try connecting to the internet and try again"
        case .badResponse(let statusCode):
            errorTitle = "Bad Resonse"
            errorMessage = "ERROR \(statusCode)"
        case .jsonDecodingError:
            errorTitle = "Bad URL"
            errorMessage = "Bad URL"
        case .IMDbAPIError(let message):
            errorTitle = "IMDb Error"
            errorMessage = message
        }
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        return alert
    }
}
