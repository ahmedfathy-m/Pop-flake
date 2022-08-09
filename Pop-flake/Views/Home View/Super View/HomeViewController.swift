//
//  HomeViewController.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 05/08/2022.
//

import UIKit

class HomeViewController: UIViewController, ViewControllerProtocol {
    weak var coordinator: AppCoordinator?
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    let tableView: UITableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
    let subViewModels: [SubViewModelProtocol] = [ComingSoonViewModel(),
                                                 InTheatersSubViewModel(),
                                                 TopMoviesViewModel(),
                                                 BoxOfficeViewModel(),
                                                 MovieTrailersViewModel()]
    lazy var handler = TableViewHandler(subViewModels: subViewModels)
    var timer = Timer()
    var scrollingCounter = 0
    lazy var collectionView: UICollectionView = {
        let header = tableView.headerView(forSection: 0) as! MovieTrailersHeader
        let collectionView = header.collectionView
        return collectionView
    }()

    fileprivate func initializeSubViewModels() {
        subViewModels.forEach { viewModel in
            viewModel.home = self
        }
        subViewModels.forEach { viewModel in
            Task.init {
                do {
                    DispatchQueue.main.async {
                        self.loadingIndicator.startAnimating()
                    }
                    try await viewModel.initializeModel()
                    DispatchQueue.main.async {
                        self.loadingIndicator.stopAnimating()
                        self.tableView.refreshControl?.endRefreshing()
                    }
                } catch {
                    if let error = error as? IMDbErrorHandler {
                        present(error.alertView, animated: true)
                    } else {
                        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                        present(alert, animated: true)
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(tableViewPulled), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    @objc func tableViewPulled(sender: UIRefreshControl) {
        initializeSubViewModels()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        let safeAreaInsets = self.view.safeAreaInsets
        let safeAreaWidth = self.view.frame.width - safeAreaInsets.left - safeAreaInsets.right
        let safeAreaHeight = self.view.frame.height - safeAreaInsets.top - safeAreaInsets.bottom
        let safeAreaFrame = CGRect(x: safeAreaInsets.left, y: safeAreaInsets.top, width: safeAreaWidth, height: safeAreaHeight)
        tableView.frame = safeAreaFrame
        view.addSubview(loadingIndicator)
        loadingIndicator.center = view.center
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        loadingIndicator.hidesWhenStopped = true
        tableView.isHidden = true
        tableView.register(MoviesHListCell.loadNib(), forCellReuseIdentifier: MoviesHListCell.identifier)
        tableView.register(MovieTrailersHeader.self, forHeaderFooterViewReuseIdentifier: "Header")
        tableView.register(BoxOfficeTable.loadNib(), forCellReuseIdentifier: BoxOfficeTable.identifier)
        tableView.dataSource = handler
        tableView.delegate = handler
        view.addSubview(tableView)
        initializeSubViewModels()
        DispatchQueue.main.async {
            self.collectionView.backgroundColor = .clear
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.nextTrailer), userInfo: nil, repeats: true)
        }
        view.backgroundColor = .white
        self.title = "Home"
        self.tabBarItem.image = UIImage(systemName: "house.fill")
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func endedLoading() {
        subViewModels.forEach { viewModel in
            if !(viewModel.loadingHasEnded) {
                return
            } else {
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.tableView.isHidden = false
                }
            }
        }
    }
    @objc func nextTrailer() {
        if !(collectionView.visibleCells.isEmpty) {
            collectionView.isPagingEnabled = false
            scrollingCounter = collectionView.indexPath(for: collectionView.visibleCells[0])?.row ?? 0
            scrollingCounter += 1
            if scrollingCounter > collectionView.numberOfItems(inSection: 0) - 1 {
                scrollingCounter = 0
            }
            collectionView.scrollToItem(at: IndexPath(row: scrollingCounter, section: 0), at: .right, animated: true)
            collectionView.isPagingEnabled = true
        }
    }
}
