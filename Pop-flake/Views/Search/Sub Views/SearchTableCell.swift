//
//  SearchTableCell.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 09/08/2022.
//

import UIKit

class SearchTableCell: UITableViewCell {
    @IBOutlet weak var searchTitle: UILabel!
    @IBOutlet weak var searchInfo: UILabel!
    @IBOutlet weak var searchItemImage: UIImageView!
    var clickableLink: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func loadNib() -> UINib {
        return UINib(nibName: "SearchTableCell", bundle: nil)
    }
    static let identifier = "SearchTableCell"
}
