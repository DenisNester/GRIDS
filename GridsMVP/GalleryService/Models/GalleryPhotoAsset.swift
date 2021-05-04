//
//  GalleryPhotoAsset.swift
//  GalleryService
//
//  Created by Uladzislau Vasilyeu on 3/25/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import Photos
import UIKit

public class GalleryPhotoAsset: GalleryAsset {
    convenience init?(photoAsset: PHAsset) {
        guard photoAsset.mediaType == .image else { return nil }
        self.init(phAsset: photoAsset)
    }
    
    override public func previewImage(onComplete: ((UIImage?) -> Void)?) {
        requestId = GalleryServiceCacheAssetsManager.instance?.generatePreview(for: self, onComplete: { [weak self] (previewImage, _) in
            self?.progress = 1.0
            onComplete?(previewImage)
        })
    }
    
    public func image(targetSize: CGSize = PHImageManagerMaximumSize, contentMode: GalleryAssetContentMode = .aspectFit, onComplete: ((UIImage?) -> Void)?) {
        let requestOptions = PHImageRequestOptions()
        
        requestOptions.isNetworkAccessAllowed = true
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        
        requestId = PHImageManager.default().requestImage(for: phAsset, targetSize: targetSize, contentMode: contentMode.phContentMode, options: requestOptions) { (image, info) in
            DispatchQueue.main.async { [weak self] in
                self?.progress = 1.0
                onComplete?(image)
            }
        }
    }
}

extension GalleryPhotoAsset: GalleryServiceURLProtocol {
    public func getURL(_ onComplete: ((URL?) -> Void)?) {
        let options = PHContentEditingInputRequestOptions()
        
        options.isNetworkAccessAllowed = true
        options.canHandleAdjustmentData = { (adjustmeta: PHAdjustmentData) -> Bool in
            return true
        }
        
        phAsset.requestContentEditingInput(with: options, completionHandler: { (contentEditingInput, info) in
            onComplete?(contentEditingInput?.fullSizeImageURL)
        })
    }
}
