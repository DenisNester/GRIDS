//
//  GridImageScrollView.swift
//  GridsMVP
//
//  Created by admin on 3.05.21.
//

import UIKit

class GridImageScrollView: UIScrollView{
    
    var imageZoomView: UIImageView!
    
    func set(image: UIImage) {
        imageZoomView?.removeFromSuperview()
        imageZoomView = nil
        imageZoomView = UIImageView(image: image)
        self.addSubview(imageZoomView)
        
        configureFor(imageSize: image.size)
    }
    
    func configureFor(imageSize: CGSize) {
        self.contentSize = imageSize
    }
}

