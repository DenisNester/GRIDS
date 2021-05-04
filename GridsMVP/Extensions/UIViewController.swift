//
//  UIViewController.swift
//  GridsMVP
//
//  Created by admin on 1.05.21.
//

import UIKit

extension UIViewController {
    
    func removeChild() {
        self.children.forEach {
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
    }
    
}
