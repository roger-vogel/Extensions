//
//  PRPickerViewExtension.swift
//  Starfish Constellation
//
//  Created by Roger Vogel on 2/25/22.
//

import Foundation
import UIKit

public extension UIPickerView {
    
    // MARK: - METHODS
    @discardableResult func setRow(forKey: String, inData: [String], forComponent: Int? = 0) -> Int? {
        
        guard !forKey.isEmpty && !inData.isEmpty else { return nil }
   
        for (index,value) in inData.enumerated() {
            
            if forKey == value {
                
                self.selectRow(index, inComponent: forComponent!, animated: false)
                return index
            }
        }
        
        return nil
    }
    
    @discardableResult func setRow(forState: String) -> Bool {
        
        for (index,value) in States.us.enumerated() {
            
            if forState == value.name || forState == value.abbrev {
                
                self.selectRow(index, inComponent: 0, animated: false)
                return true
            }
        }
        
        return false
    }
}
