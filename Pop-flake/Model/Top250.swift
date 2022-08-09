//
//  Top250.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 08/08/2022.
//

import UIKit

struct Top250: IMDbModelProtocol {
    var errorMessage: String
    let items: [Top250Item]
}

struct Top250Item: Decodable {
    let movieID: String
    let rank: String
    let title: String
    let fullTitle: String
    let year: String
    let image: String
    let crew: String
    let imDbRating: String
    let imDbRatingCount: String
    var starRating: NSMutableAttributedString {
        var image = UIImage(systemName: "star.fill")
        image = image?.withTintColor(.systemYellow)
        let imageAttachment = NSTextAttachment(image: image!)
        let attachmentString = NSMutableAttributedString(attachment: imageAttachment)
        let rating: NSMutableAttributedString = NSMutableAttributedString(string: "\(imDbRating)/10.0")
        attachmentString.append(rating)
        return attachmentString
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
    enum CodingKeys: String, CodingKey {
        case movieID = "id"
        case rank, title, fullTitle, year, image, crew, imDbRating, imDbRatingCount
    }
}
