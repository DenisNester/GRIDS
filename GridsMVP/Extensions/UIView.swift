//
//  UIView.swift
//  GridsMVP
//
//  Created by admin on 30.04.21.
//

import UIKit

extension UIView {
func makeConstraintsToSuperview() {
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
    }
}
