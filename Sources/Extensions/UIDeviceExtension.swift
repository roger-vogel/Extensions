//
//  PRUIDeviceExtension.swift
//  Starfish Constellation
//
//  Created by Roger Vogel on 2/25/22.
//

import Foundation
import UIKit

public enum Model : String {

    case simulator     = "simulator",

    iPod1              = "iPod 1",
    iPod2              = "iPod 2",
    iPod3              = "iPod 3",
    iPod4              = "iPod 4",
    iPod5              = "iPod 5",

    iPad               = "iPad",
    iPad3G             = "iPad 3G",
    iPad2              = "iPad 2",
    iPad3              = "iPad 3",
    iPad4              = "iPad 4",
    iPadAir            = "iPad Air ",
    iPadAir2           = "iPad Air 2",
    iPadAir3           = "iPad Air 3",
    iPadAir4           = "iPad Air 4",
    iPadAir5           = "iPad Air 5",
    iPad5              = "iPad 5",
    iPad6              = "iPad 6",
    iPad7              = "iPad 7",
    iPad8              = "iPad 8",
    iPad9              = "iPad 9",
    iPad10             = "iPad 10",
    iPadMini           = "iPad Mini",
    iPadMini2          = "iPad Mini 2",
    iPadMini3          = "iPad Mini 3",
    iPadMini4          = "iPad Mini 4",
    iPadMini5          = "iPad Mini 5",
    iPadMini6          = "iPad Mini 6",
    iPadPro            = "iPad Pro",
    iPadPro_9_7        = "iPad Pro 9.7\"",
    iPadPro_10_5       = "iPad Pro 10.5\"",
    iPadPro_11         = "iPad Pro 11\"",
    iPadPro_12_9       = "iPad Pro 12.9\"",
    iPadPro2           = "IPad Pro 2",
    iPadPro2_10_5      = "iPad Pro 2 10.5\"",
    iPadPro2_12_9      = "iPad Pro 2 12.9\"",
    iPadPro3           = "IPad Pro 3",
    iPadPro3_11        = "iPad Pro 3 11\"",
    iPadPro3_12_9      = "iPad Pro 3 12.9\"",
    iPadPro4           = "IPad Pro 4",
    iPadPro4_11        = "iPad Pro 4 11\"",
    iPadPro4_12_9      = "iPad Pro 4 12.9\"",
    iPadPro5           = "IPad Pro 5",
    iPadPro5_11        = "iPad Pro 5 11\"",
    iPadPro5_12_9      = "iPad Pro 5 12.9\"",
    iPadPro6           = "IPad Pro 6",
    iPadPro6_11        = "IPad Pro 6 11\"",
    iPadPro6_12_9      = "iPad Pro 6 12.9\"",
   
    iPhone4            = "iPhone 4",
    iPhone4S           = "iPhone 4S",
    iPhone5            = "iPhone 5",
    iPhone5S           = "iPhone 5S",
    iPhone5C           = "iPhone 5C",
    iPhone6            = "iPhone 6",
    iPhone6Plus        = "iPhone 6 Plus",
    iPhone6S           = "iPhone 6S",
    iPhone6SPlus       = "iPhone 6S Plus",
    iPhone7            = "iPhone 7",
    iPhone7Plus        = "iPhone 7 Plus",
    iPhoneSE           = "iPhone SE",
    iPhone8            = "iPhone 8",
    iPhone8Plus        = "iPhone 8 Plus",
    iPhoneX            = "iPhone X",
    iPhoneXS           = "iPhone XS",
    iPhoneXSMax        = "iPhone XS Max",
    iPhoneXR           = "iPhone XR",
    iPhone11           = "iPhone 11",
    iPhone11Pro        = "iPhone 11 Pro",
    iPhone11ProMax     = "iPhone 11 Pro Max",
    iPhoneSE2          = "iPhone SE2",
    iPhone12           = "iPhone 12",
    iPhone12Pro        = "iPhone 12 Pro",
    iPhone12ProMax     = "iPhone 12 Pro Max",
    iPhone12Mini       = "iPhone 12 Mini",
    iPhone13           = "iPhone 13",
    iPhone13Pro        = "iPhone 13 Pro",
    iPhone13ProMax     = "iPhone 13 Pro Max",
    iPhone13Mini       = "iPhone 13 Mini",
    iPhoneSE3          = "iPhone SE3",
    iPhone14           = "iPhone 14",
    iPhone14Plus       = "iPhone 14 Plus",
    iPhone14Pro        = "iPhone 14 Pro",
    iPhone14ProMax     = "iPhone 14 ProMax",
    
    AppleTV            = "Apple TV",
    AppleTV_4K         = "Apple TV 4K",
    unrecognized       = "?unrecognized?"
}

public extension UIDevice {
    
    // MARK: - COMPUTED PROPERTIES
    var type: Model {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let modelCode = withUnsafePointer(to: &systemInfo.machine) { $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in String.init(validatingUTF8: ptr) } }
     
        let modelMap : [String: Model] = [
            
            "i386"      : .simulator,
            "x86_64"    : .simulator,
            
            "iPod1,1"   : .iPod1,
            "iPod2,1"   : .iPod2,
            "iPod3,1"   : .iPod3,
            "iPod4,1"   : .iPod4,
            "iPod5,1"   : .iPod5,
            
            "iPad1,1"   : .iPad,
            "iPad1,2"   : .iPad,
            "iPad2,1"   : .iPad2,
            "iPad2,2"   : .iPad2,
            "iPad2,3"   : .iPad2,
            "iPad2,4"   : .iPad2,
            "iPad2,5"   : .iPadMini,
            "iPad2,6"   : .iPadMini,
            "iPad2,7"   : .iPadMini,
            "iPad3,1"   : .iPad3,
            "iPad3,2"   : .iPad3,
            "iPad3,3"   : .iPad3,
            "iPad3,4"   : .iPad4,
            "iPad3,5"   : .iPad4,
            "iPad3,6"   : .iPad4,
            "iPad4,1"   : .iPadAir,
            "iPad4,2"   : .iPadAir,
            "iPad4,3"   : .iPadAir,
            "iPad4,4"   : .iPadMini2,
            "iPad4,5"   : .iPadMini2,
            "iPad4,6"   : .iPadMini2,
            "iPad4,7"   : .iPadMini3,
            "iPad4,8"   : .iPadMini3,
            "iPad4,9"   : .iPadMini3,
            "iPad5,1"   : .iPadMini4,
            "iPad5,2"   : .iPadMini4,
            "iPad5,3"   : .iPadAir2,
            "iPad5,4"   : .iPadAir2,
            "iPad6,3"   : .iPadPro_9_7,
            "iPad6,4"   : .iPadPro_9_7,
            "iPad6,7"   : .iPadPro_12_9,
            "iPad6,8"   : .iPadPro_12_9,
            "iPad6,11"  : .iPad,
            "iPad6,12"  : .iPad,
            "iPad7,1"   : .iPadPro2,
            "iPad7,2"   : .iPadPro2,
            "iPad7,3"   : .iPadPro2_10_5,
            "iPad7,4"   : .iPadPro2_10_5,
            "iPad7,5"   : .iPad6,
            "iPad7,6"   : .iPad6,
            "iPad7,11"  : .iPad7,
            "iPad7,12"  : .iPad7,
            "iPad8,1"   : .iPadPro3_11,
            "iPad8,2"   : .iPadPro3_11,
            "iPad8,3"   : .iPadPro3_11,
            "iPad8,4"   : .iPadPro3_11,
            "iPad8,5"   : .iPadPro3_12_9,
            "iPad8,6"   : .iPadPro3_12_9,
            "iPad8,7"   : .iPadPro3_12_9,
            "iPad8,8"   : .iPadPro3_12_9,
            "iPad8,9"   : .iPadPro4_11,
            "iPad8,10"  : .iPadPro4_11,
            "iPad8,11"  : .iPadPro4_12_9,
            "iPad8,12"  : .iPadPro4_12_9,
            "iPad11,1"  : .iPadMini5,
            "iPad11,2"  : .iPadMini5,
            "iPad11,3"  : .iPadAir3,
            "iPad11,4"  : .iPadAir3,
            "iPad11,6"  : .iPad8,
            "iPad11,7"  : .iPad8,
            "iPad12,1"  : .iPad9,
            "iPad12,2"  : .iPad9,
            "iPad13,1"  : .iPadAir4,
            "iPad13,2"  : .iPadAir4,
            "iPad13,4"  : .iPadPro5_11,
            "iPad13,5"  : .iPadPro5_11,
            "iPad13,6"  : .iPadPro5_11,
            "iPad13,7"  : .iPadPro5_11,
            "iPad13,8"  : .iPadPro5_12_9,
            "iPad13,9"  : .iPadPro5_12_9,
            "iPad13,10" : .iPadPro5_12_9,
            "iPad13,11" : .iPadPro5_12_9,
            "iPad13,16" : .iPadAir5,
            "iPad13,17" : .iPadAir5,
            "iPad13,18" : .iPad10,
            "iPad13,19" : .iPad10,
            "iPad14,1"  : .iPadMini6,
            "iPad14,2"  : .iPadMini6,
            "iPad14,3"  : .iPadPro4_11,
            "iPad14,4"  : .iPadPro4_11,
            "iPad14,5"  : .iPadPro6_12_9,
            "iPad14,6"  : .iPadPro6_12_9,
       
            "iPhone3,1" : .iPhone4,
            "iPhone3,2" : .iPhone4,
            "iPhone3,3" : .iPhone4,
            "iPhone4,1" : .iPhone4S,
            "iPhone5,1" : .iPhone5,
            "iPhone5,2" : .iPhone5,
            "iPhone5,3" : .iPhone5C,
            "iPhone5,4" : .iPhone5C,
            "iPhone6,1" : .iPhone5S,
            "iPhone6,2" : .iPhone5S,
            "iPhone7,1" : .iPhone6Plus,
            "iPhone7,2" : .iPhone6,
            "iPhone8,1" : .iPhone6S,
            "iPhone8,2" : .iPhone6SPlus,
            "iPhone8,4" : .iPhoneSE,
            "iPhone9,1" : .iPhone7,
            "iPhone9,3" : .iPhone7,
            "iPhone9,2" : .iPhone7Plus,
            "iPhone9,4" : .iPhone7Plus,
            "iPhone10,1" : .iPhone8,
            "iPhone10,4" : .iPhone8,
            "iPhone10,2" : .iPhone8Plus,
            "iPhone10,5" : .iPhone8Plus,
            "iPhone10,3" : .iPhoneX,
            "iPhone10,6" : .iPhoneX,
            "iPhone11,2" : .iPhoneXS,
            "iPhone11,4" : .iPhoneXSMax,
            "iPhone11,6" : .iPhoneXSMax,
            "iPhone11,8" : .iPhoneXR,
            "iPhone12,1" : .iPhone11,
            "iPhone12,3" : .iPhone11Pro,
            "iPhone12,5" : .iPhone11ProMax,
            "iPhone12,8" : .iPhoneSE2,
            "iPhone13,1" : .iPhone12Mini,
            "iPhone13,2" : .iPhone12,
            "iPhone13,3" : .iPhone12Pro,
            "iPhone13,4" : .iPhone12ProMax,
            "iPhone14,2" : .iPhone13Pro,
            "iPhone14,3" : .iPhone13ProMax,
            "iPhone14,4" : .iPhone13Mini,
            "iPhone14,5" : .iPhone13,
            "iPhone14,6" : .iPhoneSE3,
            "iPhone14,7" : .iPhone14,
            "iPhone14,8" : .iPhone14Plus,
            "iPhone15,2" : .iPhone14Pro,
            "iPhone15,3" : .iPhone14ProMax,
            
            "AppleTV5,3" : .AppleTV,
            "AppleTV6,2" : .AppleTV_4K
        ]
        
        if let model = modelMap[modelCode!] {
            
            if model == .simulator {
                
                if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                    
                    if let simModel = modelMap[simModelCode] {
                        
                        return simModel
                    }
                }
            }
            
            return model
        }
        
        return Model.unrecognized
    }
    
    var name: String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let modelCode = withUnsafePointer(to: &systemInfo.machine) { $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in String.init(validatingUTF8: ptr) } }
        
        let modelMap : [String: String] = [
            
            "i386"       : "simulator",
            "x86_64"     : "simulator",
            
            "iPod1,1"    : "iPod 1",
            "iPod2,1"    : "iPod 2",
            "iPod3,1"    : "iPod 3",
            "iPod4,1"    : "iPod 4",
            "iPod5,1"    : "iPod 5",
            
            "iPad1,1"    : "iPad",
            "iPad1,2"    : "iPad",
            "iPad2,1"    : "iPad 2",
            "iPad2,2"    : "iPad 2",
            "iPad2,3"    : "iPad",
            "iPad2,4"    : "iPad",
            "iPad2,5"    : "iPad Mini",
            "iPad2,6"    : "iPad Mini",
            "iPad2,7"    : "iPad Mini",
            "iPad3,1"    : "iPad 3",
            "iPad3,2"    : "iPad 3",
            "iPad3,3"    : "iPad 3",
            "iPad3,4"    : "iPad 4",
            "iPad3,5"    : "iPad 4",
            "iPad3,6"    : "iPad 4",
            "iPad4,1"    : "iPad Air",
            "iPad4,2"    : "iPad Air",
            "iPad4,3"    : "iPad Air",
            "iPad4,4"    : "Pad Mini 2",
            "iPad4,5"    : "Pad Mini 2",
            "iPad4,6"    : "Pad Mini 2",
            "iPad4,7"    : "Pad Mini 3",
            "iPad4,8"    : "Pad Mini 3",
            "iPad4,9"    : "Pad Mini 3",
            "iPad5,1"    : "Pad Mini 4",
            "iPad5,2"    : "Pad Mini 4",
            "iPad5,3"    : "iPad Air 2",
            "iPad5,4"    : "iPad Air 2",
            "iPad6,3"    : "iPad Pro 9x7",
            "iPad6,4"    : "iPad Pro 9x7",
            "iPad6,7"    : "iPad Pro 12x9",
            "iPad6,8"    : "iPad Pro 12x9",
            "iPad6,11"   : "iPad",
            "iPad6,12"   : "iPad",
            "iPad7,1"    : "iPad Pro 2",
            "iPad7,2"    : "iPad Pro 2",
            "iPad7,3"    : "iPad Pro 2 10x5",
            "iPad7,4"    : "iPad Pro 2 10x5",
            "iPad7,5"    : "iPad6",
            "iPad7,6"    : "iPad6",
            "iPad7,11"   : "iPad7",
            "iPad7,12"   : "iPad7",
            "iPad8,1"    : "iPad Pro 3 11",
            "iPad8,2"    : "iPad Pro 3 11",
            "iPad8,3"    : "iPad Pro 3 11",
            "iPad8,4"    : "iPad Pro 3 11",
            "iPad8,5"    : "iPad Pro 3 12x9",
            "iPad8,6"    : "iPad Pro 3 12x9",
            "iPad8,7"    : "iPad Pro 3 12x9",
            "iPad8,8"    : "iPad Pro 3 12x9",
            "iPad8,9"    : "iPad Pro 4 11",
            "iPad8,10"   : "iPad Pro 4 11",
            "iPad8,11"   : "iPad Pro 4 12x9",
            "iPad8,12"   : "iPad Pro 4 12x9",
            "iPad11,1"   : "iPad Mini 5",
            "iPad11,2"   : "iPad Mini 5",
            "iPad11,3"   : "iPad Air 3",
            "iPad11,4"   : "iPad Air 3",
            "iPad11,6"   : "iPad 8",
            "iPad11,7"   : "iPad 8",
            "iPad12,1"   : "iPad 9",
            "iPad12,2"   : "iPad 9",
            "iPad13,1"   : "iPad Air 4",
            "iPad13,2"   : "iPad Air 4",
            "iPad13,4"   : "iPad Pro 5 11",
            "iPad13,5"   : "iPad Pro 5 11",
            "iPad13,6"   : "iPad Pro 5 11",
            "iPad13,7"   : "iPad Pro 5 11",
            "iPad13,8"   : "iPad Pro 5 12x9",
            "iPad13,9"   : "iPad Pro 5 12x9",
            "iPad13,10"  : "iPad Pro 5 12x9",
            "iPad13,11"  : "iPad Pro 5 12x9",
            "iPad13,16"  : "iPad Air5",
            "iPad13,17"  : "iPad Air5",
            "iPad13,18"  : "iPad 10",
            "iPad13,19"  : "iPad 10",
            "iPad14,1"   : "iPad Mini 6",
            "iPad14,2"   : "iPad Mini 6",
            "iPad14,3"   : "iPad Pro 4 11",
            "iPad14,4"   : "iPad Pro 4 11",
            "iPad14,5"   : "iPad Pro 6 12x9",
            "iPad14,6"   : "iPad Pro 6 12x9",
       
            "iPhone3,1"  : "iPhone 4",
            "iPhone3,2"  : "iPhone 4",
            "iPhone3,3"  : "iPhone 4",
            "iPhone4,1"  : "iPhone 4S",
            "iPhone5,1"  : "iPhone 5",
            "iPhone5,2"  : "iPhone 5",
            "iPhone5,3"  : "iPhone 5C",
            "iPhone5,4"  : "iPhone 5C",
            "iPhone6,1"  : "iPhone 5S",
            "iPhone6,2"  : "iPhone 5S",
            "iPhone7,1"  : "iPhone 6 Plus",
            "iPhone7,2"  : "iPhone 6",
            "iPhone8,1"  : "iPhone 6S",
            "iPhone8,2"  : "iPhone 6S Plus",
            "iPhone8,4"  : "iPhone SE",
            "iPhone9,1"  : "iPhone 7",
            "iPhone9,3"  : "iPhone 7",
            "iPhone9,2"  : "iPhone 7 Plus",
            "iPhone9,4"  : "iPhone 7 Plus",
            "iPhone10,1" : "iPhone 8",
            "iPhone10,4" : "iPhone 8",
            "iPhone10,2" : "iPhone 8 Plus",
            "iPhone10,5" : "iPhone 8 Plus",
            "iPhone10,3" : "iPhoneX",
            "iPhone10,6" : "iPhoneX",
            "iPhone11,2" : "iPhoneXS",
            "iPhone11,4" : "iPhone XS Max",
            "iPhone11,6" : "iPhone XS Max",
            "iPhone11,8" : "iPhone XR",
            "iPhone12,1" : "iPhone 11",
            "iPhone12,3" : "iPhone 11 Pro",
            "iPhone12,5" : "iPhone 11 Pro Max",
            "iPhone12,8" : "iPhone SE 2",
            "iPhone13,1" : "iPhone 12 Mini",
            "iPhone13,2" : "iPhone 12",
            "iPhone13,3" : "iPhone 12 Pro",
            "iPhone13,4" : "iPhone 12 Pro Max",
            "iPhone14,2" : "iPhone 13 Pro",
            "iPhone14,3" : "iPhone 13 Pro Max",
            "iPhone14,4" : "iPhone 13 Mini",
            "iPhone14,5" : "iPhone 13",
            "iPhone14,6" : "iPhone SE 3",
            "iPhone14,7" : "iPhone 14",
            "iPhone14,8" : "iPhone 14 Plus",
            "iPhone15,2" : "iPhone 14 Pro",
            "iPhone15,3" : "iPhone 14 Pro Max",
            
            "AppleTV5,3" : "Apple TV",
            "AppleTV6,2" : "Apple TV 4K"
        ]
        
        if let model = modelMap[modelCode!] {
            
            if model == "simulator" {
                
                if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                    
                    if let simModel = modelMap[simModelCode] {
                        
                        return simModel
                    }
                }
            }
            
            return model
        }
        
        return ""
    }
}
