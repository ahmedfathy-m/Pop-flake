//
//  AppCoordinator.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 05/08/2022.
//

import UIKit
//import Eureka

class AppCoordinator: BaseCoordinator {
    let tabPages: [ViewControllerProtocol] = [HomeViewController(), SearchViewController(), SettingsViewController()]
    override func start() {
        let tabView = UITabBarController()
        tabView.navigationController?.setNavigationBarHidden(true, animated: false)
        configureTabs(in: tabView)
        navigationController.pushViewController(tabView, animated: true)
    }
    fileprivate func configureTabs(in tabView: UITabBarController) {
        tabView.tabBar.tintColor = UIColor(named: "FGColor")
        tabPages.forEach { viewController in
            viewController.coordinator = self
            tabView.addChild(viewController)
        }
    }
    func goToComplaintsView() {
        let view = ComplaintsView()
        view.coordinator = self
        navigationController.pushViewController(view, animated: true)
    }
}
