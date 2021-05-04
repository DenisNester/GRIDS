//
//  GalleryView.swift
//  GridsMVP
//
//  Created by admin on 29.04.21.
//

import UIKit

class GalleryView: UIView {
    
    @IBOutlet weak private(set) var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTableView()
    }
    
    func setUpTableView(with dataSource: UITableViewDataSource, and delegate: UITableViewDelegate) {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
    
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: K.tableCellNibName, bundle: nil), forCellReuseIdentifier: K.tableCellReusableIdentifier)
        tableView.backgroundColor = .black
    }
    
    
    
}


