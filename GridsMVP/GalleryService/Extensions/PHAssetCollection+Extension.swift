//
//  PHAssetCollection+Extension.swift
//  GalleryService
//
//  Created by Uladzislau Vasilyeu on 3/30/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import Photos

extension PHAssetCollection {
    public var assetsCount: Int {
        let fetchOptions = PHFetchOptions()
        let result = PHAsset.fetchAssets(in: self, options: fetchOptions)
        return result.count
    }
}

extension PHFetchResult where ObjectType == PHAssetCollection {
    var collectionGalleryAlbums: [GalleryAlbum] {
        var albums = [GalleryAlbum]()
        
        enumerateObjects { (collection, _, _) in

            albums.append(GalleryAlbum(phAssetCollection: collection))
        }
        
        return albums
    }
}
