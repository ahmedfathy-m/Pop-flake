//
//  BoxOfficeTableCell.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 08/08/2022.
//

import UIKit

class BoxOfficeTableCell: UITableViewCell {
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var timeInTheaters: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    var clickableLink: String?
    var revenue: (weekly: String, gross: String)? {
        didSet {
            revenueLabel.text = "\(revenue?.weekly ?? "$00M") this week, \(revenue?.gross ?? "$00M") in total"
        }
    }
    var theatersTime: String? {
        didSet {
            timeInTheaters.text = "In theaters for the past \(theatersTime ?? "#") week(s)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func loadNib() -> UINib {
        return UINib(nibName: "BoxOfficeTableCell", bundle: nil)
    }
    static let identifier = "BoxOfficeTableCell"
}
