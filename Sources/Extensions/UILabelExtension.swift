//
//  UILabelExtension.swift
//  Flirte
//
//  Created by Roger Vogel on 7/11/22.
//

import Foundation
import UIKit

public extension UILabel {
    
    // MARK: - METHODS
    
    func shrinkWrap() {
        
        var labelWidth = self.text!.widthofString(withFont: self.font)
        var fontSize = font.fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.size) as! CGFloat
        let familyName = font.fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.name) as! String
        
        while labelWidth >= self.frame.width {
            
            fontSize -= 1
            self.font = UIFont(name: familyName, size: fontSize)
            labelWidth = self.text!.widthofString(withFont: self.font)
        }
    }
}
