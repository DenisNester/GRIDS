//
//  GalleryServicePreviewProtocol.swift
//  VSBL
//
//  Created by Uladzislau Vasilyeu on 3/31/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import UIKit


public protocol GalleryServicePreviewProtocol {
    func previewImage(onComplete: ((UIImage?) -> Void)?)
}
