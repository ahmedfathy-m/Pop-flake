//
//  +UIImage.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 08/08/2022.
//

import UIKit

extension UIImageView {
    fileprivate func setNoPicture() {
        DispatchQueue.main.async {
            self.image = UIImage(named: "nopicture")
        }
    }
    func downloadImage(from url: String?) async throws {
        guard let url = url else {
            setNoPicture()
            return
        }
        guard let imageURL = URL(string: url) else {
            setNoPicture()
            return
        }
        let (imageData, _) = try await URLSession.shared.data(from: imageURL)
        guard let image = UIImage(data: imageData) else {
            setNoPicture()
            return
        }
        DispatchQueue.main.async {
            self.image = image
        }
    }
}

extension UIImage {
    static func downloadImage(string: String?) async throws -> UIImage? {
        guard let imageURL = URL(string: string ?? "") else { return nil }
        let (data, _) = try await URLSession.shared.data(from: imageURL)
        let image = UIImage(data: data)
        return image
    }
}
