//
//  GalleryAssetContentMode.swift
//  GalleryService
//
//  Created by Uladzislau Vasilyeu on 3/30/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import Photos

public enum GalleryAssetContentMode {
    case aspectFill
    case aspectFit
    
    var phContentMode: PHImageContentMode {
        switch self {
            case .aspectFit: return .aspectFit
            case .aspectFill: return .aspectFill
        }
    }
}
