//
//  NumberFormatterExtension.swift
//  InView
//
//  Created by Roger Vogel on 10/13/22.
//

import Foundation

public extension NumberFormatter {
    
    func setup(grouping: Bool? = true, groupingSize: Int? = 3, showDecimal: Bool? = true, maxDecimal: Int? = 2, minDecimal: Int? = 2) {
        
        self.usesGroupingSeparator = grouping!
        self.groupingSize = groupingSize!
        self.alwaysShowsDecimalSeparator = showDecimal!
        self.minimumFractionDigits = minDecimal!
        self.maximumFractionDigits = maxDecimal!
    }
    
    func update(grouping: Bool? = nil, groupingSize: Int? = nil, showDecimal: Bool? = nil, maxDecimal: Int? = nil, minDecimal: Int? = nil) {
        
        if grouping != nil { self.usesGroupingSeparator = grouping! }
        if groupingSize != nil { self.groupingSize = groupingSize! }
        if showDecimal != nil { self.alwaysShowsDecimalSeparator = showDecimal! }
        if maxDecimal != nil { maximumFractionDigits = maxDecimal! }
        if minDecimal != nil { minimumFractionDigits = minDecimal!}
    }
    
    func revertToDefault() {
        
        self.usesGroupingSeparator = true
        self.groupingSize = 3
        self.alwaysShowsDecimalSeparator = true
        self.minimumFractionDigits = 2
        self.maximumFractionDigits = 2
    }
}
