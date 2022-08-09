//
//  CollectionViewHandler.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 05/08/2022.
//

import UIKit

class CollectionViewHandler: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    var viewModel: SubViewModelProtocol?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.entryCount ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCardCell.identifier, for: indexPath) as! MovieCardCell
        viewModel?.configure(cell, at: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCardCell
        print(cell.clickableLink)
        UIApplication.shared.open(URL(string: cell.clickableLink ?? "https://www.imdb.com/")!)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
extension CollectionViewHandler: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 162, height: 329)
    }
}

extension CollectionViewHandler: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.x
        if position > scrollView.contentSize.width - (UIScreen.main.bounds.width) + 100 {
            Task.init {
                try await viewModel?.getNextPage()
            }
        }
    }
}
