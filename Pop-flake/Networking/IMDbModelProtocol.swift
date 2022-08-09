//
//  IMDbModelProtocol.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 06/08/2022.
//

import Foundation

protocol IMDbModelProtocol: Decodable {
    var errorMessage: String { get }
}
