//
//  GalleryServiceFetchService.swift
//  GalleryService
//
//  Created by Uladzislau Vasilyeu on 3/25/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import Photos

public typealias GalleryFetchServiceAlbumAssets = (album: GalleryAlbum, assets: [GalleryAsset])

public class GalleryServiceFetchService {
    public static func fetchAllAssets(sortDescriptors: [GalleryFetchSortDescriptor] = [.creationDate(ascending: false)],
                                      onComplete: @escaping (([GalleryAsset], GalleryAuthorizeError?) -> Void)) {
        getAssets(sortDescriptors: sortDescriptors) { (assets, error) in
            onComplete(assets, error)
        }
    }
    
    public static func fetchAssets(from album: GalleryAlbum,
                                   sortDescriptors: [GalleryFetchSortDescriptor] = [.creationDate(ascending: false)],
                                   onComplete: @escaping ((_ media: GalleryFetchServiceAlbumAssets, _ error: GalleryAuthorizeError?) -> Void)) {
        getAssets(from: album, sortDescriptors: sortDescriptors) { (assets, error) in
            onComplete((album, assets), error)
        }
    }
    
    public static func fetchAlbums(onComplete: @escaping (([GalleryAlbum], GalleryAuthorizeError?) -> Void)) {
        GalleryServicePermissionManager.isAllowedAccess { (status) in
            switch status {
                case .authorized:
                    let phAssetCollectionGalleryAlbums: [GalleryAlbum] = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil).collectionGalleryAlbums
                    
                    let phAssetSmartCollectionsGalleryAlbums: [GalleryAlbum] = Array<PHAssetCollectionSubtype>(arrayLiteral:
                        .smartAlbumUserLibrary,
                        .smartAlbumRecentlyAdded,
                        .smartAlbumVideos,
                        .smartAlbumSlomoVideos,
                        .smartAlbumSelfPortraits,
                        .smartAlbumScreenshots
                    ).compactMap { PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: $0, options: nil) }
                     .flatMap { $0.collectionGalleryAlbums }
                        
                    var albumsSet = Set<GalleryAlbum>()
                    [phAssetCollectionGalleryAlbums,
                     phAssetSmartCollectionsGalleryAlbums
                    ].forEach { albumsSet.formUnion($0) }
                    
                    var albumsArray = Array(albumsSet).filter { $0.assetsCount > 0 }.sorted(by: { $0.identifier > $1.identifier })
                    if let userLibraryAlbumIndex = albumsArray.firstIndex(where: { $0.phAssetCollection.assetCollectionSubtype == .smartAlbumUserLibrary }) {
                        let userLibraryAlbum = albumsArray.remove(at: userLibraryAlbumIndex)
                        albumsArray.insert(userLibraryAlbum, at: 0)
                    }
                    
                    onComplete(albumsArray, nil)
                    
                case .denied:
                    onComplete([], .denied)
                    
                case .notDetermined:
                    GalleryServicePermissionManager.requestAllowAccess { (_) in
                        fetchAlbums(onComplete: onComplete)
                    }
                    
                case .restricted, .unknown:
                    onComplete([], .unknown)
            }
        }
    }
    
    private static func getAssets(from album: GalleryAlbum? = nil, sortDescriptors: [GalleryFetchSortDescriptor] = [.creationDate(ascending: false)], onComplete: @escaping ((_ assets: [GalleryAsset], _ error: GalleryAuthorizeError?) -> Void)) {
        GalleryServicePermissionManager.isAllowedAccess { (status) in
            switch status {
                case .authorized:
                    let fetchOptions = PHFetchOptions()
                    fetchOptions.sortDescriptors = sortDescriptors.compactMap { $0.nsSortDescriptor }
                    
                    let phAssets: PHFetchResult<PHAsset>
                    if let album = album {
                        phAssets = PHAsset.fetchAssets(in: album.phAssetCollection, options: fetchOptions)
                    } else {
                        phAssets = PHAsset.fetchAssets(with: fetchOptions)
                    }
                    
                    onComplete(phAssets.galleryAssets, nil)
                    
                case .denied:
                    onComplete([], .denied)
                    
                case .notDetermined:
                    GalleryServicePermissionManager.requestAllowAccess { (_) in
                        getAssets(from: album, sortDescriptors: sortDescriptors, onComplete: onComplete)
                    }
                    
                case .restricted, .unknown:
                    onComplete([], .unknown)
            }
        }
    }
}
