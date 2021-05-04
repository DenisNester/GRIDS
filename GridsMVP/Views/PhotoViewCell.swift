//
//  PhotoViewCell.swift
//  GridsMVP
//
//  Created by admin on 28.04.21.
//

import UIKit

class PhotoViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    var imageValue: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    
    func setUpCell(with photo: UIImage?) {
        guard let image = photo else { return }
        imageValue = image
        self.layer.cornerRadius = 6
    }
}


