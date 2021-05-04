//
//  UIApplication.swift
//  GridsMVP
//
//  Created by admin on 29.04.21.
//


import UIKit

extension UIApplication {
    var topSafeAreaInsets: CGFloat {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0
    }
    var bottomSafeAreaInsets: CGFloat {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
    }
}
