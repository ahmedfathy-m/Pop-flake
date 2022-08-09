//
//  SearchResultModel.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 09/08/2022.
//

import Foundation

struct SearchResultModel: IMDbModelProtocol {
    var errorMessage: String
    let searchType: String
    let expression: String
    let results: [SearchResultEntry]
}

struct SearchResultEntry: Decodable {
    let id: String
    let resultType: String
    let image: String
    let title: String
    let description: String
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
