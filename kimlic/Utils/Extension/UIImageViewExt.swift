//
//  UIImageViewExt.swift
//  kimlic
//
//  Created by İzzet Öztürk on 28.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import UIKit

extension UIImageView {
    func downloadedFrom(link: String?) {
        guard let url = URL(string: link ?? "") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
        
    }
}
