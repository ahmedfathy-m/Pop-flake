//
//  MoviesHListCell.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 05/08/2022.
//

import UIKit

class MoviesHListCell: UITableViewCell {
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    let handler = CollectionViewHandler()
    var subViewModel: SubViewModelProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 162, height: 329)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
        collectionView.register(MovieCardCell.loadNib(), forCellWithReuseIdentifier: MovieCardCell.identifier)
        collectionView.dataSource = handler
        collectionView.delegate = handler
        collectionView.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    static func loadNib() -> UINib {
        return UINib(nibName: "MoviesHListCell", bundle: nil)
    }
    static let identifier = "MoviesHListCell"
}

extension MoviesHListCell: SubViewModelDelegate {
    func didUpdateDataModel() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
