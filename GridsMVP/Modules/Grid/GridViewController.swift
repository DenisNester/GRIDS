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
        
        sourceView.setupScrollView(with: self)
        
        if UIDevice.current.hasTopNotch {
            sourceView.bottomNavigationBarToSafeArea.constant = 18
        } else {
            sourceView.bottomNavigationBarToSafeArea.constant = 0
        }
        
    }
    
    @IBAction func gridSizeButtonPressed(_ sender: UIButton) {
        
        switch sender.currentTitle {
        case "3x1":
            sourceView.containerViewHeight.constant = sourceView.areaForScrollView.bounds.height / 5
        case "3x2":
            sourceView.containerViewHeight.constant = (sourceView.areaForScrollView.bounds.height / 5) * 2
        case "3x3":
            sourceView.containerViewHeight.constant = (sourceView.areaForScrollView.bounds.height / 5) * 3
        case "3x4":
            sourceView.containerViewHeight.constant = (sourceView.areaForScrollView.bounds.height / 5) * 4
        case "3x5":
            sourceView.containerViewHeight.constant = (sourceView.areaForScrollView.bounds.height / 5) * 5
        default:
            break
        }
        UIView.animate(withDuration: 0) { [weak self] in
            self?.sourceView.layoutIfNeeded()
        }
        
    }
}


extension GridViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return sourceView.imageScrollView.imageZoomView
    }
    
}
