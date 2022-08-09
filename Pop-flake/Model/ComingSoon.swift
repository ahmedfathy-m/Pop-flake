//
//  ComingSoon.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 07/08/2022.
//

import Foundation

struct ComingSoonList: IMDbModelProtocol {
    let items: [ComingSoonItem]
    var errorMessage: String
}

struct ComingSoonItem: Decodable {
    let movieID: String
    let title: String
    let fullTitle: String
    let year: String
    let releaseState: String
    let image: String?
    let runtimeMins: String?
    let runtimeStr: String?
    let plot: String?
    let contentRating: String?
    let imDbRating: String?
    let imDbRatingCount: String?
    let metacriticRating: String?
    let genres: String?
    let genreList: [GenreList]?
    let directors: String?
    let directorList: [DirectorList]?
    let stars: String?
    let starList: [StarList]?
    
    var posterSizeImage: String {
        if (image?.contains("._V")) == true {
            let start = NSString(string: image!).range(of: "._V").lowerBound
            let end = NSString(string: image!).length - 1
            let length = end - start + 1
            let range = NSRange(location: start, length: length)
            let text = NSString(string: image!).replacingCharacters(in: range, with: "._V1_UX128_CR0,3,128,176_AL_.jpg")
            return text
        } else {
            return image!
        }
    }
    enum CodingKeys: String, CodingKey {
        case movieID = "id"
        case title, fullTitle, year, releaseState, image, runtimeMins, runtimeStr, plot, contentRating, imDbRating, imDbRatingCount, metacriticRating
        case genres, genreList, directors, directorList, stars, starList
    }
}
