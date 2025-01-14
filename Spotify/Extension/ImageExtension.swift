//
//  ImageExtension.swift
//  Spotify
//
//  Created by Dwistari on 05/01/25.
//

import UIKit

extension UIImageView {
    func loadImage(url: String, placeholder: UIImage?) {
        
        guard let url = URL(string: url) else {
            return
        }
        
        self.image = placeholder
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Failed to load image: \(String(describing: error))")
                return
            }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }.resume()
    }
}
