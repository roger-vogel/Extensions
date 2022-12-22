//
//  UIButtonExtension.swift
//  Flirte
//
//  Created by Roger Vogel on 8/5/22.
//

import Foundation
import UIKit

public extension UIButton {
    
    func shrinkWrap() {
        
        let buttonTitleLabel = self.titleLabel!
        let buttonTitle = buttonTitleLabel.text!
        let buttonFont = buttonTitleLabel.font
        var titleWidth = buttonTitle.widthofString(withFont: buttonFont!)
        var fontSize = buttonFont!.pointSize
    
        while titleWidth >= self.frame.width {
            
            fontSize -= 1
            buttonTitleLabel.font = UIFont(name: buttonFont!.familyName, size: fontSize)
            titleWidth = buttonTitleLabel.text!.widthofString(withFont: buttonTitleLabel.font)
        }
    }
}
