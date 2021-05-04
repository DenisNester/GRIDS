//
//  PHAuthorizationStatus+Extension.swift
//  GalleryService
//
//  Created by Uladzislau Vasilyeu on 3/25/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import Photos

extension PHAuthorizationStatus {
    var galleryAuthorizeStatus: GalleryAuthorizeStatus {
        switch self {
            case .authorized: return .authorized
            case .denied: return .denied
            case .notDetermined: return .notDetermined
            case .restricted: return .restricted
            
            @unknown default: return .unknown
        }
    }
}
