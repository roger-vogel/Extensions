//
//  PRNSDictionaryExtension.swift
//  Starfish Constellation
//
//  Created by Roger Vogel on 3/8/22.
//

import Foundation
import UIKit

public extension NSDictionary {
    
    // MARK: - COMPUTED PROPERTIES
    var asPrettyJSON : String? {
        
        do {

            let incomingData = try JSONSerialization.data(withJSONObject: self as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
            return (String(data: incomingData, encoding: .utf8)!)
         
        } catch { return nil }
    }
}
