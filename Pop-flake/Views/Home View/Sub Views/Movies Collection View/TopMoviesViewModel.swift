//
//  TopMoviesViewModel.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 08/08/2022.
//

import UIKit

final class TopMoviesViewModel: SubViewModelProtocol {
    private var isPaginating = false
    var loadingHasEnded: Bool = false {
        didSet {
            home?.endedLoading()
        }
    }
    func initializeModel() async throws {
        cachedChunk = ([], [])
        paginationIndex = 0
        try await fetchDataModel()
    }
    weak var home: HomeViewController?
    weak var delegate: SubViewModelDelegate?
    var paginationIndex = 0
    var dataModel: Top250? {
        didSet {
            Task.init {
                try await getNextChunk(currentIndex: paginationIndex, chunkSize: 20)
            }
        }
    }
    private var cachedChunk: (items: [Top250Item], images: [UIImage])? {
        didSet {
            delegate?.didUpdateDataModel()
            isPaginating = false
            loadingHasEnded = true
        }
    }
    func getNextPage() async throws {
        guard !isPaginating else { return }
        isPaginating = true
        try await getNextChunk(currentIndex: paginationIndex, chunkSize: 20)
    }
    private func getNextChunk(currentIndex: Int, chunkSize: Int) async throws {
        var lastIndex = currentIndex + chunkSize - 1
        if lastIndex > (dataModel?.items.count ?? (lastIndex)) - 1 {
            lastIndex = (dataModel?.items.count ?? (lastIndex)) - 1
        }
        guard lastIndex > currentIndex else {
            return
        }
        let extractedItems = dataModel?.items[currentIndex...lastIndex]
        var images = [UIImage]()
        guard let extractedItems = extractedItems else { return }
        for item in extractedItems {
            if let imageURL = URL(string: item.posterSizeImage) {
                let (imageData, _) = try await URLSession.shared.data(from: imageURL)
                if let image = UIImage(data: imageData) {
                    images.append(image)
                }
            } else {
                images.append(UIImage(named: "nopicture")!)
            }
        }
        cachedChunk?.items.append(contentsOf: extractedItems)
        cachedChunk?.images.append(contentsOf: images)
        paginationIndex += chunkSize
    }
    var entryCount: Int {
        return cachedChunk?.items.count ?? 0
    }
    func fetchDataModel() async throws {
        dataModel = try await IMDbHandler(key: Keys.apiKey).fetchResponse(endPoint: .top250, method: .GET)
    }
    func configure(_ cell: UIView, at indexPath: IndexPath) {
        let cell = cell as! MovieCardCell
        if let movie = cachedChunk?.items[indexPath.row], let image = cachedChunk?.images[indexPath.row] {
            cell.movieTitle.text = movie.title
            cell.movieRating.attributedText = movie.starRating
            cell.releaseYear.text = movie.year
            cell.movieImage.image = image
            cell.viewershipRating.text = ""
            cell.runtime.text = ""
            cell.clickableLink = "https://www.imdb.com/title/\(movie.movieID)"
        }
    }
}
