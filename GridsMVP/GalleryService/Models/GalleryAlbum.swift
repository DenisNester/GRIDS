//
//  GalleryAlbum.swift
//  GalleryService
//
//  Created by Uladzislau Vasilyeu on 3/25/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import Photos
import UIKit

public class GalleryAlbum: Equatable {
    public var identifier: String { phAssetCollection.localIdentifier }
    public var name: String? { phAssetCollection.localizedTitle }
    public var assetsCount: Int { phAssetCollection.assetsCount }
    
    public private(set) var preview: UIImage?
    
    let phAssetCollection: PHAssetCollection
    
    init(phAssetCollection: PHAssetCollection) {
        self.phAssetCollection = phAssetCollection
    }
}

extension GalleryAlbum: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    public static func == (lhs: GalleryAlbum, rhs: GalleryAlbum) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}



