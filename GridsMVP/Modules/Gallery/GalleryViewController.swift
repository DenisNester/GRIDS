//
//  GalleryViewController.swift
//  GridsMVP
//
//  Created by admin on 29.04.21.
//

protocol GalleryTableViewDelegate: class {
    func album(in viewController: GalleryViewController, didSelect index: Int)
}

protocol GalleryTableViewDataSource: class {
    func album(for index: Int) -> GalleryAlbum
    func albumsCount() -> Int
    
}

protocol ParentViewControllerDelegate: class {
    func hideContainer()
}


import UIKit

class GalleryViewController: UIViewController {
    
    private let presenter = HomePresenter()
    private var sourceView: GalleryView { view as! GalleryView }
    
    private(set) var selectedAlbum: GalleryAlbum?
    
    weak var delegate: GalleryTableViewDelegate?
    weak var dataSource: GalleryTableViewDataSource?
    weak var parentControllerDelegate: ParentViewControllerDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        sourceView.setUpTableView(with: self, and: self)
    }
}

extension GalleryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.albumsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableCellReusableIdentifier, for: indexPath) as! GalleryTableViewCell
        cell.backgroundColor = .black
        guard let album = dataSource?.album(for: indexPath.row) else { return .init() }
        cell.setUpCell(with: album)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.album(in: self, didSelect: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
        parentControllerDelegate?.hideContainer()
    }
    
}
