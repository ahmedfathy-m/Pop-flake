//
//  BoxOfficeItem.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 05/08/2022.
//

import Foundation

struct BoxOfficeMovie: Decodable {
    let movieID: String
    let rank: String
    let title: String
    let image: String
    let weekend: String
    let gross: String
    let weeks: String
    enum CodingKeys: String, CodingKey {
        case movieID = "id"
        case rank, title, weekend, gross, weeks, image
    }
    var posterSizeImage: String {
        if image.contains("._V") {
            let start = NSString(string: image).range(of: "._V").lowerBound
            let end = NSString(string: image).length - 1
            let length = end - start + 1
            let range = NSRange(location: start, length: length)
            let text = NSString(string: image).replacingCharacters(in: range, with: "._V1_UX128_CR0,3,128,176_AL_.jpg")
            return text
        } else {
            return image
        }
    }
}

struct BoxOffice: IMDbModelProtocol {
    let items: [BoxOfficeMovie]
    let errorMessage: String
}
