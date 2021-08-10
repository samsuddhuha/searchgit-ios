//
//  ViewExtension.swift
//  searchgit
//
//  Created by Samsud Dhuha on 09/08/21.
//

import Foundation
import UIKit

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func dropShadow(color: UIColor = UIColor.lightGray, opacity: Float = 0.3, offSet: CGSize =  CGSize(width: -1, height: 1), radius: CGFloat = 3, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
      }
    
}
