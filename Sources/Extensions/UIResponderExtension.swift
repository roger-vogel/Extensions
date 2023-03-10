//
//  PRUIResponderExtension.swift
//  Starfish Constellation
//
//  Created by Roger Vogel on 2/25/22.
//

import Foundation
import UIKit

public extension UIResponder {
  
    // MARK: - METHODS
    
    func getParentViewController() -> UIViewController? {
        
        var nextResponder = self
        
        while let next = nextResponder.next {
            
            nextResponder = next
            if let viewController = nextResponder as? UIViewController { return viewController }
        }
        
        return nil
    }
}
