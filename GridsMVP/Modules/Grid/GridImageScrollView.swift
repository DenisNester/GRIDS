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
        imageZoomView.contentMode = .center
        self.addSubview(imageZoomView)
        
        configureFor(imageSize: image.size)
    }
    
    func configureFor(imageSize: CGSize) {
        self.contentSize = imageSize
        setCurrentMaxAndMinZoomScale()
    }
    
    func setCurrentMaxAndMinZoomScale() {
        let boundSize = self.bounds.size
        let imageSize = imageZoomView.bounds.size
        
        let xScale = boundSize.width / imageSize.width
        let yScale = boundSize.height / imageSize.height
        
        let minScale = min(xScale, yScale)
        
        var maxScale: CGFloat = 1
        
        if minScale < 0.1 {
            maxScale = 0.3
        }
        
        if minScale >= 0.1 && minScale < 0.5 {
            maxScale = 0.7
        }
        
        if minScale >= 0.5 {
            maxScale = max(1.0, minScale)
        }
        
        self.minimumZoomScale = minScale
        self.maximumZoomScale = maxScale
        
    }
}

