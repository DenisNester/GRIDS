//
//  GridView.swift
//  GridsMVP
//
//  Created by admin on 3.05.21.
//

import UIKit

class GridView: UIView {
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var gridOneXThreeButton: UIButton!
    @IBOutlet weak var gridThreeXTwoButton: UIButton!
    @IBOutlet weak var gridThreeXThreeButton: UIButton!
    @IBOutlet weak var gridThreeXFourButton: UIButton!
    @IBOutlet weak var gridThreeXFiveButton: UIButton!
    
    @IBOutlet weak var bottomNavigationBarToSafeArea: NSLayoutConstraint!
    
    @IBOutlet weak var areaForScrollView: UIView!
    @IBOutlet weak var containerForScrollView: UIView!
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    
    var imageScrollView: GridImageScrollView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageScrollView = GridImageScrollView()
        
        self.containerForScrollView.addSubview(imageScrollView)
        
        setupGridImageScrollView()
        
        imageScrollView.set(image: #imageLiteral(resourceName: "autumn"))
        
        setupGridButtonFor(button: gridOneXThreeButton, with: "3x1", and: #imageLiteral(resourceName: "3x1"))
        setupGridButtonFor(button: gridThreeXTwoButton, with: "3x2", and: #imageLiteral(resourceName: "3x2"))
        setupGridButtonFor(button: gridThreeXThreeButton, with: "3x3", and: #imageLiteral(resourceName: "3x3"))
        setupGridButtonFor(button: gridThreeXFourButton, with: "3x4", and: #imageLiteral(resourceName: "3x4"))
        setupGridButtonFor(button: gridThreeXFiveButton, with: "3x5", and: #imageLiteral(resourceName: "3x5"))
    }
    
    func setupScrollView(with delegate: UIScrollViewDelegate) {
        imageScrollView.delegate = delegate
    }
    
    private func setupGridImageScrollView() {
        imageScrollView.bounces = false
        imageScrollView.alwaysBounceHorizontal = false
        imageScrollView.decelerationRate = .fast
        imageScrollView.showsVerticalScrollIndicator = false
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false // позволяет нам устанавливать свои констрейнты
        imageScrollView.topAnchor.constraint(equalTo: containerForScrollView.topAnchor).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: containerForScrollView.bottomAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: containerForScrollView.leadingAnchor, constant: 0).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: containerForScrollView.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setupGridButtonFor(button: UIButton, with title: String, and image: UIImage) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.alignTextBelow()
    }
    
    override func layoutSubviews() {
        containerViewHeight.constant = areaForScrollView.bounds.height / 5
    }
    
}
