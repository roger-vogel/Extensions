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
    
    func setLeftPadding(_ amount: CGFloat = 10) {

            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.bounds.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }

        func setRightPadding(_ amount: CGFloat = 10) {

            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.bounds.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
}
