//
//  UIImageView+Extension.swift
//  MVVMProducts
//
//  Created by Pankaj Sachdeva on 05.12.23.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
