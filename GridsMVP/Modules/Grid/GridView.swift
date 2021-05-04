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
    
    private var containerForScrollView: UIView!
    
    var imageScrollView: GridImageScrollView!
    
    
//    var containerForScrollViewHeight: CGFloat!
    
    private let scrollViewLeftAndRightInsets: CGFloat = 40
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        containerForScrollViewHeight = safeAreaForScrollView.bounds.height / 5
        imageScrollView = GridImageScrollView()
        containerForScrollView = UIView()
        
        self.areaForScrollView.addSubview(containerForScrollView)
        self.containerForScrollView.addSubview(imageScrollView)
        
        setupContainerForScrollView()
        setupGridImageScrollView()
        
        imageScrollView.set(image: #imageLiteral(resourceName: "autumn"))
        
        setupGridButtonFor(button: gridOneXThreeButton, with: "1x3", and: #imageLiteral(resourceName: "3x1"))
        setupGridButtonFor(button: gridThreeXTwoButton, with: "3x2", and: #imageLiteral(resourceName: "3x2"))
        setupGridButtonFor(button: gridThreeXThreeButton, with: "3x3", and: #imageLiteral(resourceName: "3x3"))
        setupGridButtonFor(button: gridThreeXFourButton, with: "3x4", and: #imageLiteral(resourceName: "3x4"))
        setupGridButtonFor(button: gridThreeXFiveButton, with: "3x5", and: #imageLiteral(resourceName: "3x5"))
    }
    
    
    private func setupGridImageScrollView() {
        imageScrollView.showsVerticalScrollIndicator = false
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false // позволяет нам устанавливать свои констрейнты
        imageScrollView.topAnchor.constraint(equalTo: containerForScrollView.topAnchor).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: containerForScrollView.bottomAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: containerForScrollView.leadingAnchor, constant: 0).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: containerForScrollView.trailingAnchor, constant: 0).isActive = true
    }
    
    
    private func setupContainerForScrollView() {
        containerForScrollView.backgroundColor = .black
        containerForScrollView.translatesAutoresizingMaskIntoConstraints = false
        containerForScrollView.heightAnchor.constraint(equalToConstant: areaForScrollView.bounds.height / 5).isActive = true
        containerForScrollView.widthAnchor.constraint(equalToConstant: areaForScrollView.bounds.width - scrollViewLeftAndRightInsets).isActive = true
        containerForScrollView.centerYAnchor.constraint(equalTo: areaForScrollView.centerYAnchor).isActive = true
        containerForScrollView.centerXAnchor.constraint(equalTo: areaForScrollView.centerXAnchor).isActive = true
//        containerForScrollView.trailingAnchor.constraint(equalTo: safeAreaForScrollView.trailingAnchor, constant: 20).isActive = true
//        containerForScrollView.leadingAnchor.constraint(equalTo: safeAreaForScrollView.leadingAnchor, constant: 20).isActive = true
    }
    
    private func setupGridButtonFor(button: UIButton, with title: String, and image: UIImage) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.alignTextBelow()
    }
    
}
