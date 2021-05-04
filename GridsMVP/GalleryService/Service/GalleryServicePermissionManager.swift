//
//  GalleryServicePermissionManager.swift
//  VSBL
//
//  Created by Uladzislau Vasilyeu on 3/31/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import Foundation
import Photos

public class GalleryServicePermissionManager {
    public static func isAllowedAccess(onComplete: @escaping ((GalleryAuthorizeStatus) -> Void)) {
        onComplete(PHPhotoLibrary.authorizationStatus().galleryAuthorizeStatus)
    }
    
    public static func requestAllowAccess(onComplete: @escaping ((GalleryAuthorizeStatus) -> Void)) {
        PHPhotoLibrary.requestAuthorization { (requestStatus) in
            DispatchQueue.main.async {            
                onComplete(requestStatus.galleryAuthorizeStatus)
            }
        }
    }
}
