//
//  PRImageExtension.swift
//  Starfish Constellation
//
//  Created by Roger Vogel on 2/25/22.
//

import Foundation
import UIKit
import CoreGraphics

extension UIImage {
    
    // MARK: - COMPUTED PROPERTIES
    var jpeg: Data? { jpegData(compressionQuality: 1) }  // QUALITY min = 0 / max = 1
   
    var png: Data? { pngData() }
    
    var pixelData: [UInt8]? {
        
        let size = self.size
        let dataSize = size.width * size.height * 4
        var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixelData,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * Int(size.width),
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
     
        guard let cgImage = self.cgImage else { return nil }
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))

        return pixelData
    }
    
    // MARK: - METHODS
    func coord2Index(x: Int, y: Int, w: Int) -> Int { return x + (y * w) }
    
    func targetPixelData(targetFrame: CGRect) -> [UInt8] {
        
        let allPixels = pixelData
        var croppedPixels = [UInt8]()
        var cropFrame: CGRect = targetFrame
     
        let pixelsInFullWidth = Int(self.size.width) * 4
        let pixelsInFullHeight = Int(self.size.height) * 4
     
        cropFrame.origin.x *= 4
        cropFrame.origin.y *= 4
        cropFrame.size.width *= 4
        cropFrame.size.height *= 4
        
        for imageX in 0..<pixelsInFullHeight {
            
            for imageY in 0..<pixelsInFullWidth {
                
                let currentRadius = pow((Float(imageX * imageX) + Float(imageY * imageY)),0.5)
                let cropAreaRadius = targetFrame.width/2
                
                if CGFloat(currentRadius) <= cropAreaRadius {
                    
                    let redByteIndex = coord2Index(x: imageX, y: imageY, w: pixelsInFullWidth)
                    
                    croppedPixels.append(allPixels![redByteIndex])
                    croppedPixels.append(allPixels![redByteIndex+1])
                    croppedPixels.append(allPixels![redByteIndex+2])
                    croppedPixels.append(allPixels![redByteIndex+3])
                }
            }
        }
        
        return croppedPixels
    }
   
    func fileSize (url: URL) -> Int {
    
        do {
            
            let attributes = try FileManager().attributesOfItem(atPath: url.path )
            return attributes[.size] as! Int
            
        } catch { return 0 }
    }
 
    func resizeImageTo(size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
       
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
      
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
       
        return resizedImage
    }
}


