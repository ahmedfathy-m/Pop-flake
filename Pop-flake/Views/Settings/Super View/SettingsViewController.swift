//
//  SettingsViewController.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 05/08/2022.
//

import UIKit

class SettingsViewController: UIViewController, ViewControllerProtocol {
    let tableView = UITableView(frame: UIScreen.main.bounds)
    let handler = SettingsTableViewHandler()
    weak var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SettingsCell.loadNib(), forCellReuseIdentifier: SettingsCell.identifier)
        tableView.dataSource = handler
        tableView.delegate = handler
        view.addSubview(tableView)
    }
    override func viewDidAppear(_ animated: Bool) {
        handler.coordinator = coordinator
        navigationController?.setNavigationBarHidden(false, animated: false)
        let label = UILabel()
        label.text = "Settings"
        label.textColor = .black
        tabBarController?.navigationItem.titleView = label
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.backgroundColor = .white
        self.title = "Settings"
        self.tabBarItem.image = UIImage(systemName: "gearshape.fill")
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
