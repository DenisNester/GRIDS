//
//  GalleryFetchAssetType.swift
//  GalleryService
//
//  Created by Uladzislau Vasilyeu on 3/25/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import Photos

public enum GalleryFetchAssetType: CaseIterable {
    case video
    case photo
    
    var phAssetMediaType: PHAssetMediaType {
        switch self {
            case .photo: return .image
            case .video: return .video
        }
    }
}
