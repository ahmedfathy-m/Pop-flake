//
//  MovieTrailersViewModel.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 08/08/2022.
//

import UIKit

final class MovieTrailersViewModel: SubViewModelProtocol {
    var loadingHasEnded: Bool = false {
        didSet {
            home?.endedLoading()
        }
    }
    weak var home: HomeViewController?
    func initializeModel() async throws {
        try await fetchDataModel()
    }
    weak var delegate: SubViewModelDelegate?
    var entryCount: Int {
        return cachedData.trailers.count
    }
    var dataModel: InTheaters? {
        didSet {
            Task.init {
                try await getTrailers()
            }
        }
    }
    var cachedData: (trailers: [YTMovieModel], poster: [UIImage], preview: [UIImage]) = ([], [], []) {
        didSet {
            delegate?.didUpdateDataModel()
            loadingHasEnded = true
        }
    }
    func fetchDataModel() async throws {
        dataModel = try await IMDbHandler(key: Keys.apiKey).fetchResponse(endPoint: .inTheaters, method: .GET)
    }
    func getTrailers() async throws {
        var newTrailers: [YTMovieModel] = []
        var posterImages = [UIImage]()
        var previewImages = [UIImage]()
        for counter in 0...4 {
            guard let id = dataModel?.items[counter].movieID else { return }
            do {
                let trailer: YTMovieModel = try await IMDbHandler(key: Keys.apiKey).fetchResponse(endPoint: .youtube(movieID: id), method: .GET)
                let poster = try await UIImage.downloadImage(string: dataModel?.items[counter].image)
                let preview = try await UIImage.downloadImage(string: "https://img.youtube.com/vi/\(trailer.videoId)/maxresdefault.jpg")
                newTrailers.append(trailer)
                posterImages.append(poster ?? UIImage())
                previewImages.append(preview ?? UIImage())
            } catch {
                print(error)
            }
        }
        cachedData.trailers = newTrailers
        cachedData.poster = posterImages
        cachedData.preview = previewImages
    }
    func configure(_ cell: UIView, at indexPath: IndexPath) {
        let cell = cell as! MovieTrailerCell
        cell.movieTitle.text = cachedData.trailers[indexPath.row].title
        cell.moviePoster.image = cachedData.poster[indexPath.row]
        cell.trailerPreview.image = cachedData.preview[indexPath.row]
        cell.clickableLink = cachedData.trailers[indexPath.row].videoUrl
    }
}
