//
//  MovieCardCell.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 05/08/2022.
//

import UIKit

class MovieCardCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var viewershipRating: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var cell: UIStackView!
    var clickableLink: String!
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.layer.cornerRadius = 10.0
        cell.layer.cornerRadius = 10.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize(width: 0, height: 3)
    }

    static func loadNib() -> UINib {
        return UINib(nibName: "MovieCardCell", bundle: nil)
    }
    static let identifier = "MovieCardCell"
}
