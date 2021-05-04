//
//  GridViewController.swift
//  GridsMVP
//
//  Created by admin on 3.05.21.
//

import UIKit

class GridViewController: UIViewController {
    
    private let presenter = GridPresenter()
    private var sourceView: GridView { view as! GridView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.hasTopNotch {
            sourceView.bottomNavigationBarToSafeArea.constant = 18
        } else {
            sourceView.bottomNavigationBarToSafeArea.constant = 0
        }
        
    }
    
    @IBAction func gridSizeButtonPressed(_ sender: UIButton) {
        
//        switch sender.currentTitle {
//        case :
//        default:
//            break
//        }
        
        
    }
    
    
    
}
