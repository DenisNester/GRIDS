//
//  PHAsset+Extension.swift
//  LibraryService
//
//  Created by Uladzislau Vasilyeu on 3/25/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import Photos

extension PHFetchResult where ObjectType == PHAsset {
    var galleryAssets: [GalleryAsset] {
        var libraryAssets = [GalleryAsset]()
        
        enumerateObjects { (phAsset, _, _) in
            switch phAsset.mediaType {
                case .video: libraryAssets.append(GalleryVideoAsset(phAsset: phAsset))
                case .image: libraryAssets.append(GalleryPhotoAsset(phAsset: phAsset))
                
                default: break
            }
        }
        
        return libraryAssets
    }
}
