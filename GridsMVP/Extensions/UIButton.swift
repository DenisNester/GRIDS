//
//  UIButton.swift
//  GridsMVP
//
//  Created by admin on 28.04.21.
//

import UIKit

extension UIButton {
    
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 27.5

        gradientLayer.shadowColor = #colorLiteral(red: 0.9568627451, green: 0.5098039216, blue: 0.3176470588, alpha: 0.4024507636).cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 1
        gradientLayer.masksToBounds = false

        
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
    }
    
    
    func centerVertically(padding: CGFloat = 6.0) {
          guard
              let imageViewSize = self.imageView?.frame.size,
              let titleLabelSize = self.titleLabel?.frame.size else {
              return
          }
          
          let totalHeight = imageViewSize.height + titleLabelSize.height + padding
          
          self.imageEdgeInsets = UIEdgeInsets(
              top: -(totalHeight - imageViewSize.height),
              left: 0.0,
              bottom: 0.0,
              right: -titleLabelSize.width
          )
          
          self.titleEdgeInsets = UIEdgeInsets(
              top: 0.0,
              left: -imageViewSize.width,
              bottom: -(totalHeight - titleLabelSize.height),
              right: 0.0
          )
          
          self.contentEdgeInsets = UIEdgeInsets(
              top: 0.0,
              left: 0.0,
              bottom: titleLabelSize.height,
              right: 0.0
          )
      }
    
    func alignTextBelow(spacing: CGFloat = 10.0) {
        guard let image = self.imageView?.image else {
            return
        }

        guard let titleLabel = self.titleLabel else {
            return
        }

        guard let titleText = titleLabel.text else {
            return
        }

        let titleSize = titleText.size(withAttributes: [
            NSAttributedString.Key.font: titleLabel.font
        ])

        titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
    }
}

