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
}
