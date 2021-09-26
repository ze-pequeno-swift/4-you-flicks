//
//  UIImageView+Extension.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 25/08/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setupCornerImage(cornerRadius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    func circleCornerImage() {
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
    }
    
    func load(url: String, completion: (() -> Void)? = nil) {
        kf.setImage(
            with: URL(string: url),
            options: [.transition(.fade(0.3))]) { _ in
                completion?()
        }
    }
    
    func cancel() {
        kf.cancelDownloadTask()
    }
}
