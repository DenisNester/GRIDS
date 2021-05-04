//
//  GalleryServiceCacheAssetsManager.swift
//  VSBL
//
//  Created by Uladzislau Vasilyeu on 4/20/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import Photos
import UIKit

class GalleryServiceCacheAssetsManager {
    private static let previewImageSize = CGSize(width: 400, height: 400)
    
    private(set) static var instance: GalleryServiceCacheAssetsManager? = nil
    
    private let cachePreviewManager: PHCachingImageManager
    private let requestOptions: PHImageRequestOptions
    
    static func configure(with assets: [GalleryAsset]) {
        instance = GalleryServiceCacheAssetsManager(assets: assets)
    }
    
    static func clear() {
        instance = nil
    }
    
    private init(assets: [GalleryAsset]) {
        let cacheImageManager = PHCachingImageManager.default() as! PHCachingImageManager
        
        let requestOptions = PHImageRequestOptions()
        
        requestOptions.isNetworkAccessAllowed = true
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        
        self.cachePreviewManager = cacheImageManager
        self.requestOptions = requestOptions
    }
    
    deinit {
        cachePreviewManager.stopCachingImagesForAllAssets()
    }
    
    func generatePreview(for album: GalleryAlbum, onComplete: @escaping ((UIImage?, GalleryAuthorizeError?) -> Void)) {
        GalleryServicePermissionManager.isAllowedAccess { [weak self] (status) in
            switch status {
                case .authorized:
                    let fetchOptions = PHFetchOptions()
                    fetchOptions.fetchLimit = 1
                    fetchOptions.sortDescriptors = [
                        GalleryFetchSortDescriptor.creationDate(ascending: true)
                    ].compactMap { $0.nsSortDescriptor }
                    
                    let phAssets = PHAsset.fetchAssets(in: album.phAssetCollection, options: fetchOptions)
                    if let galleryAsset = phAssets.galleryAssets.first {
                        let _ = self?.generatePreview(for: galleryAsset) { (image, error) in
                            onComplete(image, (error != nil ? .unknown : nil))
                        }
                    } else {
                        onComplete(nil, .unknown)
                    }
                    
                case .denied:
                    onComplete(nil, .denied)
                    
                case .notDetermined:
                    GalleryServicePermissionManager.requestAllowAccess { [weak self] (_) in
                        self?.generatePreview(for: album, onComplete: onComplete)
                    }
                    
                case .restricted, .unknown:
                    onComplete(nil, .unknown)
            }
        }
    }
    
    func generatePreview(for asset: GalleryAsset, onComplete: @escaping ((UIImage?, Error?) -> Void)) -> PHImageRequestID {
        return cachePreviewManager.requestImage(for: asset.phAsset, targetSize: GalleryServiceCacheAssetsManager.previewImageSize, contentMode: .aspectFit, options: requestOptions) { (image, _) in
            onComplete(image, nil)
        }
    }
}
