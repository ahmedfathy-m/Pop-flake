//
//  MovieYTTrailerModel.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 08/08/2022.
//

import Foundation

struct YTMovieModel: IMDbModelProtocol {
    let imDbId: String
    let title: String
    let fullTitle: String
    let type: String
    let year: String
    let videoId: String
    let videoUrl: String
    var errorMessage: String
}
