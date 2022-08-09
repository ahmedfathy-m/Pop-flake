//
//  IMDb.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 05/08/2022.
//

import Foundation

enum IMDbEndPoint {
    case comingSoon
    case inTheaters
    case top250
    case boxOffice
    case youtube(movieID: String)
    case resizeImage(imageURL: String)
    case search(_ expression: String)
}

extension IMDbEndPoint {
    private var baseURL: String {
        return "https://imdb-api.com/en/API"
    }
    private var targetURLString: String {
        get {
            switch self {
            case .comingSoon:
                return "\(baseURL)/ComingSoon/{API_KEY}"
            case .inTheaters:
                return "\(baseURL)/InTheaters/{API_KEY}"
            case .top250:
                return "\(baseURL)/Top250Movies/{API_KEY}"
            case .boxOffice:
                return "\(baseURL)/BoxOffice/{API_KEY}"
            case .youtube(let movieID):
                return "\(baseURL)/YouTubeTrailer/{API_KEY}/\(movieID)"
            case .resizeImage(let imageURL):
                return "\(baseURL)/ResizeImage?apiKey={API_KEY}&size=128x176&url=\(imageURL)"
            case .search(let expression):
                return "\(baseURL)/Search/{API_KEY}/\(expression)"
            }
        }
        set {}
    }
    func targetURL(with apiKey: String) -> URL? {
        let finalURLString = targetURLString.replacingOccurrences(of: "{API_KEY}", with: apiKey)
        let encoded = finalURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let targetURL = URL(string: encoded!)
        return targetURL
    }
}
