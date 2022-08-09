//
//  BoxOfficeTableHandler.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 08/08/2022.
//

import UIKit

class BoxOfficeTableHandler: NSObject, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    var viewModel: SubViewModelProtocol?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.entryCount ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableCell.identifier, for: indexPath) as! BoxOfficeTableCell
        viewModel?.configure(cell, at: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! BoxOfficeTableCell
        UIApplication.shared.open(URL(string: cell.clickableLink ?? "https://www.imdb.com")!)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
