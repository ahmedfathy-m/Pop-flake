//
//  SettingsCell.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 06/08/2022.
//

import UIKit

class SettingsCell: UITableViewCell {

    @IBOutlet weak var settingTitle: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var settingIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settingIcon.tintColor = UIColor(named: "FGColor")
        settingTitle.tintColor = UIColor(named: "FGColor")
        switchButton.tintColor = UIColor(named: "FGColor")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func loadNib() -> UINib{
        return UINib(nibName: "SettingsCell", bundle: nil)
    }
    
    static let identifier = "SettingsCell"
    
}
