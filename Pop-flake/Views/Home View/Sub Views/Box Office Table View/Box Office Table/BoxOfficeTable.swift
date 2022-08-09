//
//  BoxOfficeTable.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 08/08/2022.
//

import UIKit

class BoxOfficeTable: UITableViewCell {
    @IBOutlet weak var tableView: UITableView!
    let handler = BoxOfficeTableHandler()
    var subViewModel: SubViewModelProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = handler
        tableView.delegate = handler
        tableView.register(BoxOfficeTableCell.loadNib(), forCellReuseIdentifier: BoxOfficeTableCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func loadNib() -> UINib {
        return UINib(nibName: "BoxOfficeTable", bundle: nil)
    }
    static let identifier = "BoxOfficeTable"
}

extension BoxOfficeTable: SubViewModelDelegate {
    func didUpdateDataModel() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
