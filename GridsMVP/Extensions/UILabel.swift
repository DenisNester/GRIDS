//
//  UILabel.swift
//  GridsMVP
//
//  Created by admin on 29.04.21.
//

import UIKit

extension UILabel{
func setCharacterSpacing(_ spacing: CGFloat){
    let attributedStr = NSMutableAttributedString(string: self.text ?? "")
    attributedStr.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributedStr.length))
    self.attributedText = attributedStr
 }
}
