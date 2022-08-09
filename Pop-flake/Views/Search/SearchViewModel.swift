//
//  SearchViewModel.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 09/08/2022.
//

import UIKit

class SearchViewModel {
    weak var delegate: SearchViewController?
    
    var entryCount: Int {
        return dataModel?.results.count ?? 0
    }
    
    var dataModel: SearchResultModel? {
        didSet {
            delegate?.didUpdateDataModel()
        }
    }
    
    var cachedImages = [UIImage]()
    
    func fetchDataModel(query: String) async throws {
        cachedImages = [UIImage]()
        let model: SearchResultModel = try await IMDbHandler(key: Keys.apiKey).fetchResponse(endPoint: .search(query), method: .GET)
        for result in model.results {
            if let imageURL = URL(string: result.posterSizeImage) {
                let (imageData, _) = try await URLSession.shared.data(from: imageURL)
                if let image = UIImage(data: imageData) {
                    cachedImages.append(image)
                } else {
                    cachedImages.append(UIImage(named: "nopicture")!)
                }
            }
        }
        dataModel = model
    }
    func configure(_ cell: UIView, at indexPath: IndexPath) {
        let cell = cell as! SearchTableCell
        cell.searchTitle.text = dataModel?.results[indexPath.row].title
        cell.searchInfo.text = dataModel?.results[indexPath.row].description
        cell.clickableLink = "https://www.imdb.com/title/\((dataModel?.results[indexPath.row].id) ?? "")"
        cell.searchItemImage.image = cachedImages[indexPath.row]

    }
}
