//
//  PRIntExtension.swift
//  Starfish Constellation
//
//  Created by Roger Vogel on 2/25/22.
//

import Foundation
import UIKit

extension Dictionary {
    
    // MARK: - COMPUTED PROPERTIES
    var asPrettyJSON : String? {
        
        do {

            let incomingData = try JSONSerialization.data(withJSONObject: self as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
            return (String(data: incomingData, encoding: .utf8)!)
         
        } catch { return nil }
    }
    
    // MARK: - SUBSCRIPTING
    subscript(i: Int) -> (key: Key, value: Value) {
        
        return self[index(startIndex, offsetBy: i)]
    }
}
