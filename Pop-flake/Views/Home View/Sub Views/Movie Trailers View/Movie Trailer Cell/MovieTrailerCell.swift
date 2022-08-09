//
//  MovieTrailerCell.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 07/08/2022.
//

import UIKit

class MovieTrailerCell: UICollectionViewCell {
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var trailerPreview: UIImageView!
    var clickableLink = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        moviePoster.layer.cornerRadius = 10
        // Initialization code
    }
    static func loadNib() -> UINib {
        return UINib(nibName: "MovieTrailerCell", bundle: nil)
    }
    static let identifier = "MovieTrailerCell"
}
