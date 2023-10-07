//
//  PRStringExtension.swift
//  Starfish Constellation
//
//  Created by Roger Vogel on 2/25/22.
//

import Foundation
import UIKit

public enum Justification: Int { case left, center, right }

public extension String {
    
    // MARK: - COMPUTED PROPERTIES
    var isBackspace: Bool {
        
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
    
    var isValidEmail: Bool {
        
        guard self != "" else { return true }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        
        return pred.evaluate(with: self)
    }
    
    var isValidURL: Bool {
    
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
    
            if match.range.length == self.utf16.count {  return true } else { return false }
            
        } else { return false }
    }
    
    var isValid8ByteToken: Bool {
        
        guard self.count == 19 else { return false }
   
        let tokenFormat = "XXXX-XXXX-XXXX-XXXX"
        let hexDigits = "0123456789ABCDEF"
        
        for (index,value) in self.uppercased().enumerated() {
            
            let expectedValue = tokenFormat[index]
            
            if expectedValue == "-" {
                
                if String(value) != expectedValue { return false }
                
            } else {
                
                if !hexDigits.contains(value) { return false }
            }
        }
        
        return true
    }
    
    var cleanedURL: String {
    
        var cleanString = self.removePhrase(phraseToRemove: "www.")
        if cleanString.partial(fromIndex: 0, length: 8) != "https://" { cleanString = "https://" + cleanString }
        
        return cleanString
    }
    
    var isValidPassword: (valid: Bool, message: String) {
        
        // Make sure there is something here
        guard !self.isEmpty else { return (false,"Please enter a password") }
        
        // Make sure the password is of sufficient length
        guard self.count >= 12 else { return (false,"Your password must be at least 12 characters long") }
        
        // Make sure the password contains at least one lowercase letter
        guard containsOne(of: "abcdefghijklmnopqrstuvwxyz") else { return (false,"Your password must contain at least one lowercase letter") }
        
        // Make sure the password contains at least one uppercase letter
        guard containsOne(of: "ABCDEFGHIJKLMNOPQRSTUVWXYZ") else { return (false,"Your password must contain at least one uppercase letter") }
        
        // Make sure the password contains at least one digit
        guard containsOne(of: "0123456789") else { return (false,"Your password must contain at least one number") }
        
        // Make sure the password contains at least one special character
        guard containsSpecialCharacter else { return (false,"Your password must contain at least one special character (not a letter or number") }
        
        return (true,"Good")
    }
    
    var containsSpecialCharacter: Bool {
        
        let lowercase = "abcdefghijklmnopqrstuvwxyz"
        let alphanumerics = lowercase + lowercase.uppercased() + "0123456789"
        
        for char in self { if !alphanumerics.contains(char) {
            
            return true } }
      
        return false
    }
    
    var username: (isValid: Bool, error: String?) {
        
        //let invalidCharacters: [String] = [" ",".","=","&","/","\\"]
        let nameLength : Int = self.count
        
        // Does it meet required length
        if nameLength < 5 { return (false, String(format: "Your username must be at least %d characters long", 5)) }
        
        // Does it have any unusable charactres
        //for c in 0...nameLength-1 {
            
            //let index = invalidCharacters.firstIndex(of: self[c])
            //if index != nil { return (false, "Your username can't contain a " + invalidCharacters[index!] + " character") }
        //}
            
        return (true,nil)
    }
    
    var cleanedPhone: String {
        
        guard self != "" else { return ""}
      
        let noDash = self.replacingOccurrences(of: "-", with: "")
        let noLeftParens = noDash.replacingOccurrences(of: "(", with: "")
        let noRightParens = noLeftParens.replacingOccurrences(of: ")", with: "")
        let noSpace = noRightParens.replacingOccurrences(of: " ", with: "")
        let noPlus = noSpace.replacingOccurrences(of: "+", with: "")
        
        return noPlus
    }
    
    var fromBase64: String? {
       
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    
    var toBase64: String? {
       
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
    
    var formattedPhone: String {
        
        get {
            
            guard self.count < 13 else { return self }
            
            let cleanString = self.cleanedPhone
            
            switch cleanString.count {
        
                case 10: return cleanString[0]+cleanString[1]+cleanString[2]+"-"+cleanString[3]+cleanString[4]+cleanString[5]+"-"+cleanString[6]+cleanString[7]+cleanString[8]+cleanString[9]
                case 11: return "0"+cleanString[0]+"-"+cleanString[1]+cleanString[2]+cleanString[3]+"-"+cleanString[4]+cleanString[5]+cleanString[6]+"-"+cleanString[7]+cleanString[8]+cleanString[9]+cleanString[10]
                case 12: return cleanString[0]+cleanString[1]+"-"+cleanString[2]+cleanString[3]+cleanString[4]+"-"+cleanString[5]+cleanString[6]+cleanString[7]+"-"+cleanString[8]+cleanString[9]+cleanString[10]+cleanString[11]
                    
                default: return self
            }
        }
        
        set {
            
            // MARK: - VALID CHARACTERS
            
            // If string has only digits and dashes
            if newValue.containsOnly(characters: ["0","1","2","3","4","5","6","7","8","9","-"]) { self = newValue }
            else { return }
         
            // MARK: - GOOD
            
            // If len equals 12 and we have dashes in the right places, return self
            if newValue.count == 12 && newValue[3] == "-" && newValue[7] == "-" { self = newValue }
          
            // If we have more than area code but less than suffix and has dash in right place, it's good so return self
            else if newValue.count > 4 && newValue.count < 8 && newValue[4] == "-" { self = newValue }
                
            // MARK: - ISSUES
            
            // Too Long: if len > 10 without dashes,truncate to 10
            else if newValue.count > 10 && !newValue.contains("-") { self = newValue.partial(fromIndex: 0, length: 10) }
                
            // Too Long: if len > 12 with dashes in the right places, truncate to 12
            else if newValue.count > 120 && newValue[3] == "-" && newValue[7] == "-" { self = newValue.partial(fromIndex: 0, length: 12) }
            
            else if newValue.count < 12 && newValue.contains("-") { self = newValue.cleanedPhone }
            
            // MARK: FORMAT FOR PHONE
           
            // Otherwise when we reach 10 characters add dashes
            else {
                
                if newValue.count == 10 && !newValue.contains("-") {
                    
                    let cleanNumber = newValue.cleanedPhone
                    let areaCode: String = cleanNumber.partial(fromIndex: 0, length: 3)
                    let prefix: String = cleanNumber.partial(fromIndex: 3, length: 3)
                    let suffix: String = cleanNumber.partial(fromIndex: 6, length: 4)
                    
                    self = areaCode + "-" + prefix + "-" + suffix
                    
                } else { self = newValue }
            }
        }
    }
    
    var cleanedDollar: String {
        
        var cleanString = ""
        
        for c in self { if c != "$" && c != "," { cleanString += String(c) } }
        return cleanString
    }
    
    var formattedDollar: String {
        
        var formattedString = "$"
        let formatter = NumberFormatter()
        let theAmount = NSString(string: self).doubleValue
        
        formatter.setup()
        formattedString += formatter.string(from: NSNumber(value: theAmount))!
     
        return formattedString
    }
    
    var formattedDollarRounded: String {
        
        var formattedString = "$"
        let formatter = NumberFormatter()
        let theAmount = NSString(string: self).doubleValue
        
        formatter.setup(grouping: true, groupingSize: 3, showDecimal: false, maxDecimal: 0, minDecimal: 0)
        formattedString += formatter.string(from: NSNumber(value: theAmount))!
     
        return formattedString
    }
    
    var cleanedValue: String {
        
        var cleanString = ""
        
        for c in self { if c != "," { cleanString += String(c) } }
        return cleanString
    }
    
    var formattedValue: String {
    
        let formatter = NumberFormatter()
        let theAmount = NSString(string: self).doubleValue
        
        formatter.setup(showDecimal: false, maxDecimal: 0, minDecimal: 0)
        return formatter.string(from: NSNumber(value: theAmount))!
    }
    
    var cleanedPercent: String {
        
        var cleanString = ""
        
        for c in self { if c != "%" && c != "," { cleanString += String(c) } }
        return cleanString
    }
    
    var formattedPercent: String {
        
        var formattedString = ""
        let formatter = NumberFormatter()
        let theAmount = NSString(string: self).doubleValue
        
        formatter.setup()
        formattedString = formatter.string(from: NSNumber(value: theAmount))! + " %"
     
        return formattedString
    }
    
    var isValidNumber: Bool {
        
        guard containsNoMoreThanOne(character: ".") else { return false }
        
        let digits: Set = ["0","1","2","3","4","5","6","7","8","9","."]
        
        for c in self { if !digits.contains(String(c)) { return false } }
        return true
    }
    
    var cleanedOfHiddenCharacters: String {
        
        var cleanedString = ""
        
        for index in 0..<self.count {
            
            let char = Character(self[index])
            if char.isASCII || char == "\r" || char == "\n" { cleanedString.append(self[index]) }
        }
        
        return cleanedString
    }
    
    // MARK: - METHODS
    func containsSubstring(string: String) -> Bool {
        
        // Empty strings
        guard !self.isEmpty && !string.isEmpty else { return false }
        
        // Target length > source
        guard self.count >= string.count else { return false }
        
        // Strings are of equal length, return whether or not they are equal
        guard self.count != string.count else { return self == string }
        
        // Target is smaller than the source
        for index in 0...(count-string.count) {
            
            if partial(fromIndex: index, length: string.count) == string { return true }
        }
        
        return false
    }
    
    func evaluateFor( Format: [String] ) -> Bool {
        
        // First, the format count should match the string count
        guard Format.count == self.count else {return false}
        
        // Initialize a set with base 10 digits
        let digits: Set = ["0","1","2","3","4","5","6","7","8","9"]
        let capAlphas: Set = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        let smallAlphas: Set = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
        
        // Sequence through the string comparing by character to the format string
        for c in 0...(self.count-1) {
            
            // If we're expecting a digit, check for that
            if Format[c] == "#"  {
                let evalChar: Set = [self[c]]
                if  !evalChar.isSubset(of: digits) {return false}
                else { continue }
            }
                
                // If we're expecting a small character
            else if Format[c] == "<"  {
                let evalChar: Set = [self[c]]
                if  !evalChar.isSubset(of: smallAlphas) {return false}
                else { continue }
            }
                
            // If we're expecting a cap character
            else if Format[c] == ">"  {
                let evalChar: Set = [self[c]]
                if  !evalChar.isSubset(of: capAlphas) {return false}
                else { continue }
            }
                
            // Otherwise check to see if it matches the format character
            else if ( self[c] != Format[c] ) {return false}
        }
        
        // Success if we reached this point...
        return true
    }
    
    func containsOnly(characters: [Character]) -> Bool {
        
        for c in self { if !characters.contains(c) { return false } }
        return true
    }
    
    func containsNoMoreThanOne(character: Character) -> Bool {
        
        var characterCount: Int = 0
        
        for c in self { if c == character { characterCount += 1 } }
        
        if characterCount < 2 { return true }
        else { return false }
    }
    
    func containsOne(of: String) -> Bool {
        
        for c in of {
            
            if self.contains(c)
            
            { return true } }
        
        return false
    }
    
    func asInteger (StartAtIndex:Int? = nil, NumberOfDigits:Int? = nil) -> (isInteger: Bool, intValue: Int) {
        
        var intValue: Int = 0
        var isInteger: Bool = false
        var start: Int
        var numberOfDigits: Int
        var testString: String = ""
        
        // Grab the start index or set to zero
        if (StartAtIndex == nil) {start = 0}
        else {start = StartAtIndex!}
        
        // Grab the number of digits or set to full length
        if (NumberOfDigits == nil) {numberOfDigits = self.count}
        else {numberOfDigits = NumberOfDigits!}
        
        // Build a test string consisting of the substring in question
        for c in start ... (start+numberOfDigits-1) { testString = testString + self[c] }
        
        // Check if the test string is all digit characters and if so, calculate value
        let intFormat = [String](repeating: "#", count: testString.count)
        
        if ( testString.evaluateFor(Format:intFormat) ) {
            
            for c in 1...numberOfDigits {
                
                let p: Double = Double((c-1))
                let n: Double! = Double(self[start+numberOfDigits-c])
                
                intValue = intValue + (Int)( n! * pow(10.0,p) )
            }
            
            isInteger = true
        }
        
        return (isInteger, intValue)
    }
    
    func partial (fromIndex: Int, length: Int) -> String {
        
        let fullString: String = self
        var partialString: String = ""
        
        guard length <= fullString.count && fromIndex <= (fullString.count - length) else { return "" }
        
        for i in fromIndex...(fromIndex + length - 1) { partialString += fullString[i] }
        
        return partialString
    }
    
    func addAsInt(count: Int) -> String {
        
        var p = (self as NSString).intValue
        p += Int32(count)
        
        return String(format: "%d", p)
    }
    
    func removeChar(charToRemove: String) -> String {
        
        let fullString: String = self
        var adjustedString: String = ""
        
        guard fullString.count > 0 else { return "" }
        
        for i in 0...fullString.count - 1 { if fullString[i] != charToRemove {adjustedString += fullString[i] } }
        
        return adjustedString
    }
    
    func removeCharacters(charsToRemove: [String]) -> String {
        
        var newString: String = ""
        var charStart: Bool = true
        
        for c in charsToRemove {
            
            if charStart {newString = self.replacingOccurrences(of: c, with: ""); charStart = false }
            else { newString = newString.replacingOccurrences(of: c, with: "")}
        }
        
        return newString
    }
    
    func removePhrase(phraseToRemove: String) -> String {
        
        guard phraseToRemove.count < self.count else { return self }
     
        var index: Int = 0
        var cleanedString: String = ""
        var operationComplete: Bool = false
        let phraseLength = phraseToRemove.count
        let cutoff = self.count - phraseLength
        
        while !operationComplete {
            
            if index > cutoff {
                
                if index != self.count - 1 {
                  
                    let tail = self.partial(fromIndex: index, length: self.count - index)
                    cleanedString += tail
                }
                
                operationComplete = true
                
            } else {
        
                let sourcePhrase = self.partial(fromIndex: index, length: phraseLength)
              
                if sourcePhrase == phraseToRemove { index += phraseLength }
                else { cleanedString += self[index]; index += 1 }
            }
        }
   
        return cleanedString
    }
    
    func widthofString(withFont: UIFont) -> CGFloat {
        
        let theString = NSString(string: self)
        return theString.size(withAttributes: [.font:withFont]).width
    
    }
    
    func nullSplit(delimiter: String) -> [String] {
        
        guard !self.isEmpty else { return [""] }
   
        var splitString = [String]()
        var subString = ""
        
        for aChar in self {
         
            if String(aChar) != delimiter {
                
                subString += String(aChar)
                
            } else {
           
                splitString.append(subString)
                subString = ""
            }
        }
        
        if subString != "" { splitString.append(subString) }
     
        return splitString
    }
    
    func wrapToFit(spaceAvailable: CGFloat, withFont: UIFont) -> (text: String, lines: CGFloat) {
        
        var wrappedString = ""
        var lineCounter: CGFloat = 1
   
        // Get the string width in points
        let width = self.widthofString(withFont: withFont)
        
        // If the string fits, just send it back as-is
        if width < spaceAvailable { return (self,lineCounter) }
       
        // Otherwise split it into words
        let theWords = self.split(separator: " ")
        
        // Assemble words into lines that fit
        for word in theWords {
            
            if (wrappedString + String(word)).widthofString(withFont: withFont) < spaceAvailable {
                
                wrappedString += (String(word) + " ")
                
            } else {
                
                wrappedString += ("\n" + String(word) + " ")
                lineCounter += 1
            }
        }
    
        if wrappedString.last == "\n" { wrappedString.removeLast() }
        
        return (wrappedString,lineCounter)
    }
    
    func splitString (byString: String) -> [String] {
        
        var parsedStrings = [String]()
        var wipString = ""
        var theIndex: Int?
        var theWipString: String?
     
        for (index,value) in self.enumerated() {
            
            theIndex = index
            
            if String(value) != byString { wipString += String(value) }
            else {
                
                parsedStrings.append(wipString)
                wipString = ""
            }
            
            theWipString = wipString
        }
        
        if theIndex != nil { if theIndex! == self.count-1 { parsedStrings.append(theWipString!) } }
      
        return parsedStrings
    }
    
    func textSize(font: UIFont) -> CGSize {
        
        return self.size(withAttributes: [NSAttributedString.Key.font: font])
    }
    
    func padWithSpaces(before: Int? = 0, after: Int? = 0) -> String {
        
        var beforePad = ""
        var afterPad = ""
        
        if before! != 0 { for _ in 1...before! { beforePad += " " } }
        if after! != 0 { for _ in 1...after! { afterPad += " " } }
     
        return beforePad + self + afterPad
    }
    
    func padToWidth(width: CGFloat, font: UIFont) -> String {
        
        var paddedString = self
        let stringSize = self.textSize(font: font).width
        let spaceWidth = " ".textSize(font: font).width
        
        guard stringSize < width else { return self }
        let spacesForPad = (width - stringSize)/spaceWidth
        
        for _ in 1...Int(spacesForPad) { paddedString += " " }
       
        return paddedString
    }
    
    func shiftPadToFront(count: Int) -> String {
        
        var adjustedPad = self
        
        for _ in 0..<count {
            
            if adjustedPad.last! == " " {
                
                adjustedPad.removeLast()
                adjustedPad = " " + adjustedPad
            }
        }
        
        return adjustedPad
    }
    
    func justified(textRect: CGRect, justification: Justification, font: UIFont) -> CGRect {
        
        if self.textSize(font: font).width > textRect.width { return textRect }
        
        var theTextRect = textRect
        let paddingRequired = textRect.width - self.textSize(font: font).width
        
        if justification == .left { return theTextRect }
        else if justification == .right { theTextRect.origin.x += paddingRequired }
        else { theTextRect.origin.x += (paddingRequired/2) }
            
        return theTextRect
    }
    
    
    // MARK: - SUBSCRIPTING
    subscript(i: Int) -> String {
        
        return String(self[index(startIndex, offsetBy: i)])
    }
}
