//
//  GalleryVideoAsset.swift
//  GalleryService
//
//  Created by Uladzislau Vasilyeu on 3/25/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import Photos
import UIKit

public class GalleryVideoAsset: GalleryAsset {
    public private(set) var avAsset: AVAsset?
    public private(set) var avAudioMix: AVAudioMix?
    public private(set) var assetURL: URL?
    
    convenience init?(videoAsset: PHAsset) {
        guard videoAsset.mediaType == .video else { return nil }
        self.init(phAsset: videoAsset)
    }
    
    override public func previewImage(onComplete: ((UIImage?) -> Void)?) {
        requestId = GalleryServiceCacheAssetsManager.instance?.generatePreview(for: self, onComplete: { [weak self] (previewImage, _) in
            self?.progress = 1.0
            onComplete?(previewImage)
        })
    }
    
    public func video(onComplete: ((AVAsset?, AVAudioMix?, URL?) -> Void)?) {
        let requestOptions = PHVideoRequestOptions()
        requestOptions.version = .original
        requestOptions.isNetworkAccessAllowed = true

        requestId = PHImageManager.default().requestAVAsset(forVideo: phAsset, options: requestOptions) { [weak self] (avAsset, avAudioMix, info) in
            self?.assetURL = (avAsset as? AVURLAsset)?.url
            self?.avAsset = avAsset
            self?.avAudioMix = avAudioMix
            
            DispatchQueue.main.async { [weak self] in
                self?.progress = 1.0
                onComplete?(avAsset, avAudioMix, self?.assetURL)
            }
        }
    }
}

extension GalleryVideoAsset: GalleryServiceURLProtocol {
    public func getURL(_ onComplete: ((URL?) -> Void)?) {
        onComplete?(assetURL)
    }
}

extension GalleryVideoAsset: GalleryServiceDurationProtocol {
    public var duration: GalleryAssetDuration { GalleryAssetDuration(cmTime: avAsset?.duration ?? .zero) }
}
