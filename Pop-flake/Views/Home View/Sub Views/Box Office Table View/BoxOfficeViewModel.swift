//
//  BoxOfficeViewModel.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 08/08/2022.
//

import UIKit

final class BoxOfficeViewModel: SubViewModelProtocol {
    var loadingHasEnded: Bool = false {
        didSet {
            home?.endedLoading()
        }
    }
    weak var home: HomeViewController?
    weak var delegate: SubViewModelDelegate?
    func initializeModel() async throws {
        try await fetchDataModel()
    }
    var entryCount: Int {
        return dataModel?.items.count ?? 0
    }
    var dataModel: BoxOffice? {
        didSet {
            delegate?.didUpdateDataModel()
            loadingHasEnded = true
        }
    }
    var moviePosters = [UIImage]()
    func fetchDataModel() async throws {
        let model: BoxOffice? = try await IMDbHandler(key: Keys.apiKey).fetchResponse(endPoint: .boxOffice, method: .GET)
        guard let model = model else { return }
        var posters = [UIImage]()
        for item in model.items {
            guard let image = try await UIImage.downloadImage(string: item.posterSizeImage) else { return }
            posters.append(image)
        }
        moviePosters = posters
        dataModel = model
    }
    func configure(_ cell: UIView, at indexPath: IndexPath) {
        let cell = cell as! BoxOfficeTableCell
        if let movie = dataModel?.items[indexPath.row] {
            cell.movieTitle.text = movie.title
            cell.rankLabel.text = movie.rank
            cell.revenue = (movie.weekend, movie.gross)
            cell.theatersTime = movie.weeks
            cell.clickableLink = "https://www.imdb.com/title/\(movie.movieID)"
            cell.movieImage.image = moviePosters[indexPath.row]
        }
    }
}
