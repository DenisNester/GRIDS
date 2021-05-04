//
//  GalleryTableViewCell.swift
//  GridsMVP
//
//  Created by admin on 29.04.21.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var galleryName: UILabel!
    @IBOutlet weak var galleryItemsCount: UILabel!
    
    
//    var imageValue: UIImage? {
//        get { galleryImageView.image }
//        set { galleryImageView.image = newValue }
//    }
    
    var titleValue: String? {
        get { galleryName.text }
        set { galleryName.text = newValue }
    }
    
    var countValue: String? {
        get { galleryItemsCount.text }
        set { galleryItemsCount.text = newValue }
    }
    
    func setUpCell(with album: GalleryAlbum) {
        self.selectionStyle = .none
        GalleryServiceCacheAssetsManager.instance?.generatePreview(for: album) { [weak self] (previewImage, error) in
            self?.galleryImageView.image = previewImage
            }
        titleValue = album.name
        countValue = String(album.assetsCount)
        
    }
    
    
    

    
}
