//
//  UIImage + Extensions.swift
//  FoodCollectionTestApp
//
//  Created by Alexey on 18.05.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(_ urlString: String) {
        let url = URL(string: urlString)
        kf.setImage(with: url)
    }
}
