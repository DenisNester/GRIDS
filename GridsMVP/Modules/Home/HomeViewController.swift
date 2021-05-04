//
//  HomeViewController.swift
//  GridsMVP
//
//  Created by admin on 28.04.21.
//

import UIKit
import Photos

class HomeViewController: UIViewController {
    
    private let presenter = HomePresenter()
    private var sourceView: HomeView { view as! HomeView }
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateActiveViewController()
        
        presenter.view = self
        presenter.configureLibraryAssets()
        sourceView.setUpCollectionView(with: self, and: self)
        
        if UIDevice.current.hasTopNotch {
            sourceView.topConstraintToTopView.constant = 22
            sourceView.topConstraintToSafeArea.constant = 16
            sourceView.bottomContstraintToSafeArea.constant = 48
            sourceView.containterViewToTopView.constant = 22
        } else {
            sourceView.topConstraintToTopView.constant = 0
            sourceView.topConstraintToSafeArea.constant = 0
            sourceView.bottomContstraintToSafeArea.constant = 0
            sourceView.containterViewToTopView.constant = 0
        }
    }
    
    func updateActiveViewController() {
        let galleryAlbumsVC = StoryboardScene.GalleryAlbums.initialScene.instantiate()
        galleryAlbumsVC.delegate = self
        galleryAlbumsVC.dataSource = self
        galleryAlbumsVC.parentControllerDelegate = self
        addChild(galleryAlbumsVC)
        sourceView.addToContainerView(view: galleryAlbumsVC.view)
        galleryAlbumsVC.didMove(toParent: self)
    }
    
    
    func hideContainerViewFromSourceView(duration: TimeInterval) {
        sourceView.containterViewHeight.constant = sourceView.containterViewHeight.constant == 0 ? self.sourceView.collectionView.bounds.height : 0
        UIView.animate(withDuration: duration) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func recentsButtonPressed(_ sender: UIButton) {
        
        switch sender.imageView?.image {
        case #imageLiteral(resourceName: "reversedChevron"):
            sender.setImage(#imageLiteral(resourceName: "chevron"), for: .normal)
        case #imageLiteral(resourceName: "chevron"):
            sender.setImage(#imageLiteral(resourceName: "reversedChevron"), for: .normal)
        default:
            break
        }
        hideContainerViewFromSourceView(duration: 0.3)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return presenter.selectedAlbum?.assetsCount ?? 0
        return presenter.assets.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellReusableIdentifier, for: indexPath) as! PhotoViewCell
        
        let phAsset = presenter.assets[indexPath.row].phAsset
        let imageFromAsset = presenter.getAssetThumbnail(asset: phAsset)
        
        cell.setUpCell(with: imageFromAsset)
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInsets.left * (itemsPerRow + 1)
        let avaliableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = avaliableWidth / itemsPerRow
        presenter.widthForImage = widthPerItem
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension HomeViewController: HomePresenterView {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.sourceView.collectionView.reloadData()
        }
    }
    
}

extension HomeViewController: GalleryTableViewDelegate, GalleryTableViewDataSource {
    
    func album(in viewController: GalleryViewController, didSelect index: Int) {
        presenter.selectedAlbum = presenter.albums[index]
    }
    
    func album(for index: Int) -> GalleryAlbum {
        return presenter.albums[index]
    }
    
    func albumsCount() -> Int {
        return presenter.albums.count
    }
    
}

extension HomeViewController: ParentViewControllerDelegate {
  
    func hideContainer() {
        hideContainerViewFromSourceView(duration: 0.15)
        sourceView.recentsButton.setTitle(presenter.selectedAlbum?.name, for: .normal) 
        sourceView.recentsButton.setImage(#imageLiteral(resourceName: "chevron"), for: .normal)
        presenter.configureLibraryAssets()
    }
}

