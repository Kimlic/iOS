//
//  UIImageExt.swift
//  kimlic
//
//  Created by İzzet Öztürk on 22.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import UIKit

public extension UIImage {
    func profileImageMask() -> UIImage {
        return maskedImage(mask: UIImage(named:"black_profile_mask")!)
    }
    
    // This function cuts according to the picture sent
    func maskedImage(mask: UIImage) -> UIImage {
        guard
            let imageReference = self.cgImage,
            let maskReference = mask.cgImage,
            let dataProvider = maskReference.dataProvider,
            let imageMask = CGImage(
                maskWidth: maskReference.width,
                height: maskReference.height,
                bitsPerComponent: maskReference.bitsPerComponent,
                bitsPerPixel: maskReference.bitsPerPixel,
                bytesPerRow: maskReference.bytesPerRow,
                provider: dataProvider,
                decode: nil,
                shouldInterpolate: true
            ),
            let maskedReference = imageReference.masking(imageMask)
            else { return mask }
        return UIImage(cgImage: maskedReference)
    }
    
    func getImageData() -> Data {
        return UIImageJPEGRepresentation(self, 1.0)!
    }
    
    func convertBase64() -> String {
        let imageData:Data = UIImageJPEGRepresentation(self, 1.0)!
        let dataImage = imageData.base64EncodedString(options: .endLineWithLineFeed)
        return dataImage.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    public func resizeImage(size: CGSize) -> UIImage {
        var returnImage: UIImage?
        
        var scaleFactor: CGFloat = 1.0
        var scaledWidth = size.width
        var scaledHeight = size.height
        var thumbnailPoint = CGPoint(x: 0, y: 0)
        
        
        if !self.size.equalTo(size) {
            let widthFactor = size.width / self.size.width
            let heightFactor = size.height / self.size.height
            
            if widthFactor > heightFactor {
                scaleFactor = widthFactor
            } else {
                scaleFactor = heightFactor
            }
            
            scaledWidth = self.size.width * scaleFactor
            scaledHeight = self.size.height * scaleFactor
            
            if widthFactor > heightFactor {
                thumbnailPoint.y = (size.height - scaledHeight) * 0.5
            } else if widthFactor < heightFactor {
                thumbnailPoint.x = (size.width - scaledWidth) * 0.5
            }
        }
        UIGraphicsBeginImageContextWithOptions(size, true, 0)        
        var thumbnailRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaledWidth
        thumbnailRect.size.height = scaledHeight
        
        self.draw(in: thumbnailRect)
        returnImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return returnImage!
    }
}

