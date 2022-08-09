//
//  SearchTableHandler.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 09/08/2022.
//

import UIKit

class SearchTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    let viewModel: SearchViewModel
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.entryCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableCell.identifier, for: indexPath) as! SearchTableCell
        viewModel.configure(cell, at: indexPath)
        return cell
    }
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SearchTableCell
        if let searchURL = URL(string: cell.clickableLink ?? "") {
            UIApplication.shared.open(searchURL)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
