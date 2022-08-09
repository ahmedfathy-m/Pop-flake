//
//  MovieTrailersView.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 08/08/2022.
//

import UIKit

class MovieTrailersHeader: UITableViewHeaderFooterView {
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = {
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let aspectRatio = 1.5436
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = width / aspectRatio
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    var viewModel: SubViewModelProtocol?
    var handler = TrailersCollectionHandler()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .clear
        collectionView.register(MovieTrailerCell.loadNib(), forCellWithReuseIdentifier: MovieTrailerCell.identifier)
        handler.viewModel = viewModel
        collectionView.dataSource = handler
        collectionView.delegate = handler
        self.addSubview(self.collectionView)
        collectionView.reloadSections(IndexSet(integer: 0))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieTrailersHeader: SubViewModelDelegate {
    func didUpdateDataModel() {
        DispatchQueue.main.async {
            self.collectionView.reloadSections(IndexSet(integer: 0))
            self.collectionView.reloadData()
        }
    }
}
