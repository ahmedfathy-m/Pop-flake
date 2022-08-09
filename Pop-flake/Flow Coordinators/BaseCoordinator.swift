//
//  BaseCoordinator.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 05/08/2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}

class BaseCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    init(with navController: UINavigationController) {
        self.navigationController = navController
    }
    func start() {   
    }
    deinit {
        print("deallocating \(self)")
    }
}
