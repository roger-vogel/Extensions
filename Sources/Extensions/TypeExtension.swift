//
//  PRExtensions.swift
//  PRP Resiliency Center
//
//  Created by Roger Vogel on 10/9/20.
//

import Foundation
import UIKit

public extension Int {
    
    var doubleValue: Double { return Double(self) }
    var boolValue: Bool { if self == 0 { return false } else { return true } }
}

public extension Double {
    
    var intValue: Int { return Int(self) }
    var uint64Value: UInt64 { return UInt64(self) }
}

public extension Float { var intValue: Int { return Int(self) } }

public extension CGFloat { var intValue: Int { return Int(self) } }

public extension Bool { var intValue: Int { return self ? 1 : 0 } }

public extension Array {
    
    mutating func deleteIndicesAt(indices: inout [Int]) {
        
        guard !indices.isEmpty else { return }
        
        indices.sort { $0 < $1 }
        
        remove(at: indices.first!)
        indices.remove(at: 0)
        
        for targetIndex in 0..<indices.count {
            
            indices[targetIndex] -= 1
            deleteIndicesAt(indices: &indices)
        }
    }
}
