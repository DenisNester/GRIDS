//
//  HomeView.swift
//  GridsMVP
//
//  Created by admin on 28.04.21.
//

import UIKit

class HomeView: UIView {
    
    @IBOutlet weak private(set) var collectionView: UICollectionView!
    @IBOutlet weak private(set) var recentsButton: UIButton!
    @IBOutlet weak private(set) var makeGridButton: UIButton!
    @IBOutlet weak private(set) var containerView: UIView!
    
    @IBOutlet weak private(set) var topConstraintToSafeArea: NSLayoutConstraint!
    @IBOutlet weak private(set) var bottomContstraintToSafeArea: NSLayoutConstraint!
    @IBOutlet weak private(set) var topConstraintToTopView: NSLayoutConstraint!
    @IBOutlet weak private(set) var containterViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak private(set) var containterViewToTopView: NSLayoutConstraint!
    
    private let gradient = CAGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = makeGridButton.bounds
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //        recentsButton.setImage(UIImage(named: "chevron"), for: .normal)
        containterViewHeight.constant = 0
        recentsButtonSetUp()
        setUpCollectionView()
        gridButtonSetUp()
    }
    
    func setUpCollectionView(with dataSource: UICollectionViewDataSource, and delegate: UICollectionViewDelegate) {
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }
    
    func addToContainerView(view: UIView) {
        containerView.addSubview(view)
        view.makeConstraintsToSuperview()
    }
    
    private func gridButtonSetUp() {
        makeGridButton.layer.cornerRadius = 27.5
        let colorLeft = #colorLiteral(red: 0.9490196078, green: 0.2509803922, blue: 0.2352941176, alpha: 1).cgColor
        let colorRight = #colorLiteral(red: 0.9647058824, green: 0.7137254902, blue: 0.3803921569, alpha: 1).cgColor
        gradient.colors = [colorLeft, colorRight]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.cornerRadius = 27.5
        makeGridButton.layer.addSublayer(gradient)
        
    }
    
    private func recentsButtonSetUp() {
        recentsButton.setImage(#imageLiteral(resourceName: "chevron"), for: .normal)
    }
    
    
    private func setUpCollectionView() {
        collectionView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellWithReuseIdentifier: K.cellReusableIdentifier)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 100, right: 0)
        collectionView.backgroundColor = .black
    }
    
    
}



