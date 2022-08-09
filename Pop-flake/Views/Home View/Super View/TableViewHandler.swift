//
//  TableViewHandler.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 05/08/2022.
//

import UIKit

class TableViewHandler: NSObject, UITableViewDataSource, UITableViewDelegate {
    let titles = ["Coming Soon", "In Theaters", "Top Rated Movies", "Top Box Office (US)"]
    let subViewModels: [SubViewModelProtocol]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (0...2).contains(indexPath.row) {
            let cell = tableView.dequeueReusableCell(withIdentifier: MoviesHListCell.identifier, for: indexPath) as! MoviesHListCell
            cell.cellTitle.text = titles[indexPath.row]
            cell.subViewModel = subViewModels[indexPath.row]
            cell.handler.viewModel = subViewModels[indexPath.row]
            subViewModels[indexPath.row].delegate = cell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTable.identifier, for: indexPath) as! BoxOfficeTable
            cell.subViewModel = subViewModels[indexPath.row]
            cell.handler.viewModel = subViewModels[indexPath.row]
            subViewModels[indexPath.row].delegate = cell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (0...2).contains(indexPath.row) {
            let cell = tableView.cellForRow(at: indexPath) as! MoviesHListCell
            cell.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
        } else {
            let cell = tableView.cellForRow(at: indexPath) as! BoxOfficeTable
            cell.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    init(subViewModels: [SubViewModelProtocol]) {
        self.subViewModels = subViewModels
    }
}
// MARK: - Header Functions
extension TableViewHandler {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let aspectRatio: CGFloat = 1.5436
        return tableView.frame.width / aspectRatio
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! MovieTrailersHeader
        header.viewModel = subViewModels[4]
        header.handler.viewModel = subViewModels[4]
        subViewModels[4].delegate = header
        return header
    }
}
