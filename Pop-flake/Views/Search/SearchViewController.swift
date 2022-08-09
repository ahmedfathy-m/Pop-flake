//
//  SearchViewController.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 05/08/2022.
//

import UIKit

class SearchViewController: UIViewController, ViewControllerProtocol {
    let viewModel = SearchViewModel()
    lazy var handler = SearchTableHandler(viewModel: viewModel)
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
    weak var coordinator: AppCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = handler
        tableView.delegate = handler
        viewModel.delegate = self

        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: animated)
        let safeArea = view.safeAreaInsets
        let width = UIScreen.main.bounds.width - safeArea.left - safeArea.right
        let searchBar = UISearchBar(frame: CGRect(x: safeArea.left, y: safeArea.top, width: width, height: 40))
        let tableHeight = UIScreen.main.bounds.height - safeArea.top - safeArea.bottom - 40
        tableView.scrollsToTop = false
        tableView.frame = CGRect(x: safeArea.left, y: safeArea.top + 30, width: width, height: tableHeight)
        tableView.register(SearchTableCell.loadNib(), forCellReuseIdentifier: SearchTableCell.identifier)
        searchBar.delegate = self
        view.addSubview(tableView)
        view.addSubview(searchBar)
        loadingIndicator.center = view.center
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.backgroundColor = .white
        self.title = "Search"
        self.tabBarItem.image = UIImage(systemName: "magnifyingglass")
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        loadingIndicator.startAnimating()
        Task.init {
            try await viewModel.fetchDataModel(query: searchBar.text!)
        }
    }
}

extension SearchViewController {
    func didUpdateDataModel() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            self.tableView.reloadData()
        }
    }
}
