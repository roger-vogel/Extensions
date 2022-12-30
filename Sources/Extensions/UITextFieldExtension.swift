//
//  PRTextFieldExtension.swift
//  Starfish Constellation
//
//  Created by Roger Vogel on 2/25/22.
//

import Foundation
import UIKit

public extension UITextField{
    
    // MARK: - METHODS
    
    @IBInspectable var placeholderColor: UIColor {
       
        get {
            return self.attributedPlaceholder!.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .lightText
        }
        
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [.foregroundColor: newValue])
        }
    }
   
    func setPadding(left: CGFloat = 0, right: CGFloat = 0) {
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.bounds.size.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.bounds.size.height))
        self.rightView = rightPaddingView
        self.rightViewMode = .always
    }
}
