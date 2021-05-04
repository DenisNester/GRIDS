//
//  HomePresenter.swift
//  GridsMVP
//
//  Created by admin on 28.04.21.
//

import Photos
import Foundation
import UIKit

protocol  HomePresenterView: class {
    func reloadData()
}

class HomePresenter {
    
    private(set) var albums = [GalleryAlbum]()
    private(set) var assets = [GalleryAsset]()
    var selectedAlbum: GalleryAlbum?
   
    
    weak var view: HomePresenterView?
    
    var widthForImage: CGFloat = 0
    
    func configureLibraryAssets() {
        GalleryServicePermissionManager.isAllowedAccess { [weak self] (status) in
            switch status {
            case .denied:
                break
            case .notDetermined:
                GalleryServicePermissionManager.requestAllowAccess { [weak self] (status) in
                    self?.configureLibraryAssets()
                }
                
            default:
                GalleryServiceFetchService.fetchAlbums { [weak self] (albums, error) in
                    self?.albums = albums
                    
                    if self?.selectedAlbum == nil {
                        self?.selectedAlbum = albums.first
                    }
                    
                    if let selectedAlbum = self?.selectedAlbum {
                        GalleryServiceFetchService.fetchAssets(from: selectedAlbum) { (albumAssets, error) in
                            DispatchQueue.main.async {
                                self?.assets = albumAssets.assets.reversed()
                                self?.configureCachePreviewService(for: albumAssets.assets)
                                self?.view?.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var image = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: widthForImage, height: widthForImage), contentMode: .aspectFill, options: option, resultHandler: {( result, info ) -> Void in
            image = result!
            
        })
        return image
    }
    
    private func configureCachePreviewService(for galleryAssets: [GalleryAsset]? = nil) {
        if let galleryAssets = galleryAssets {
            GalleryServiceCacheAssetsManager.configure(with: galleryAssets)
        } else {
            GalleryServiceFetchService.fetchAllAssets { (galleryAssets, error) in
                guard error == nil else { return }
                GalleryServiceCacheAssetsManager.configure(with: galleryAssets)
            }
        }
    }
    
    
    
}





