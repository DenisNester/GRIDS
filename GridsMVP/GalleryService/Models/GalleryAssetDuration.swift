//
//  GalleryAssetDuration.swift
//  VSBL
//
//  Created by Uladzislau Vasilyeu on 3/31/20.
//  Copyright © 2020 AppicStars. All rights reserved.
//

import Foundation
import CoreMedia

public class GalleryAssetDuration {
    private let cmTime: CMTime
    
    public var seconds: Double { cmTime.seconds }
    
    public init(cmTime: CMTime) {
        self.cmTime = cmTime
    }
}
