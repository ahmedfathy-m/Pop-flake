//
//  Sub View Model Protocol.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 08/08/2022.
//

import UIKit

protocol SubViewModelProtocol: AnyObject {
    var entryCount: Int {get}
    func fetchDataModel() async throws
    func configure(_ cell: UIView, at indexPath: IndexPath)
    var delegate: SubViewModelDelegate? {get set}
    func initializeModel() async throws
    var home: HomeViewController? {get set}
    var loadingHasEnded: Bool {get set}
    func getNextPage() async throws
    var paginationIndex: Int {get set}
}

extension SubViewModelProtocol where Self: MovieTrailersViewModel {
    func getNextPage() async throws {
    }
    var paginationIndex: Int {
        get {
            return 0
        }
        set {
            
        }
    }
}

extension SubViewModelProtocol where Self: BoxOfficeViewModel {
    func getNextPage() async throws {
    }
    var paginationIndex: Int {
        get {
            return 0
        }
        set {
            
        }
    }
}
