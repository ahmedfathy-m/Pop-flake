//
//  TrailersCollectionHandler.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 07/08/2022.
//

import UIKit

class TrailersCollectionHandler: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var viewModel: SubViewModelProtocol?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.entryCount ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieTrailerCell.identifier, for: indexPath) as! MovieTrailerCell
        viewModel?.configure(cell, at: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MovieTrailerCell
        if let videoURL = URL(string: cell.clickableLink) {
            UIApplication.shared.open(videoURL)
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
