//
//  GalleryFetchSortDescriptor.swift
//  GalleryService
//
//  Created by Uladzislau Vasilyeu on 3/30/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import Foundation
import Photos

public enum GalleryFetchSortDescriptor {
    case creationDate(ascending: Bool)
    
    var nsSortDescriptor: NSSortDescriptor {
        switch self {
            case .creationDate(let ascending): return NSSortDescriptor(key: #keyPath(PHAsset.creationDate), ascending: ascending)
        }
    }
}
