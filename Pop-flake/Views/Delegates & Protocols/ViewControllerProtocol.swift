//
//  ViewControllerProtocol.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 09/08/2022.
//

import UIKit

protocol ViewControllerProtocol: UIViewController {
    var coordinator: AppCoordinator? {get set}
}
