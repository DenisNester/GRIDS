//
//  GalleryAsset.swift
//  GalleryService
//
//  Created by Uladzislau Vasilyeu on 3/25/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import Photos
import UIKit

public class GalleryAsset: GalleryServicePreviewProtocol, GalleryServiceReuseProtocol {
    let phAsset: PHAsset
    var requestId: PHImageRequestID?
    
    var progress: Double = 0.0
    public var isDownloaded: Bool { progress >= 1.0 }
    
    init(phAsset: PHAsset) {
        self.phAsset = phAsset
    }
    
    deinit {
        cancelRequest()
    }
    
    public func previewImage(onComplete: ((UIImage?) -> Void)?) {        
        onComplete?(nil)
    }
    
    public func prepareForReuse() {
        cancelRequest()
    }
    
    public func cancelRequest() {
        guard let requestId = requestId else { return }
        
        PHImageManager.default().cancelImageRequest(requestId)
        PHCachingImageManager.default().cancelImageRequest(requestId)
        
        self.requestId = nil
    }
}
