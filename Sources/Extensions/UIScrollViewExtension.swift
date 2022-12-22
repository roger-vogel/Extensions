//
//  PRScrollViewExtension.swift
//  Starfish Constellation
//
//  Created by Roger Vogel on 2/25/22.
//

import Foundation
import UIKit

public extension UIScrollView {
    
    // MARK: -  METHODS
    
    func scrollsToBottom(animated: Bool) {
        
        let bottomOffset = CGPoint(x: contentOffset.x, y: contentSize.height - bounds.height + adjustedContentInset.bottom)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    func scrollsToTop(animated: Bool) {
        
        let topOffset = CGPoint(x: contentOffset.x, y: 0)
        setContentOffset(topOffset, animated: animated)
    }
    
    func sizeContentView(lastControl: UIView, contentViewHeight: inout NSLayoutConstraint) {
        
        let bottom = self.frame.origin.y + lastControl.frame.origin.y + lastControl.frame.height + 20
        contentViewHeight.constant = bottom
    }
}
