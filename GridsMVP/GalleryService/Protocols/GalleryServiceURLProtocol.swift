//
//  GalleryServiceURLProtocol.swift
//  VSBL
//
//  Created by Uladzislau Vasilyeu on 3/31/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import Foundation

public protocol GalleryServiceURLProtocol {
    func getURL(_ onComplete: ((URL?) -> Void)?)
}
