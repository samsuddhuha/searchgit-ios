//
//  TextFieldExtension.swift
//  searchgit
//
//  Created by Samsud Dhuha on 10/08/21.
//

import Foundation
import UIKit

@IBDesignable
extension UITextField{
    
    func setLeftPaddingPoints(_ size: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ size: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
