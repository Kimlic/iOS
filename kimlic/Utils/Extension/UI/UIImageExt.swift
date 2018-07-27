//
//  UIImageExt.swift
//  kimlic
//
//  Created by İzzet Öztürk on 22.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import UIKit

public extension UIImage {
    func profileImageMask() -> UIImage {
        return maskedImage(mask: #imageLiteral(resourceName: "black_profile_mask"))
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
    
    // MARK: Resize Image
    func resizeImage(size: CGSize) -> UIImage {
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
    
    public func fixedOrientation() -> UIImage {
        if imageOrientation == UIImageOrientation.up {
            return self
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case UIImageOrientation.down, UIImageOrientation.downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
            break
        case UIImageOrientation.left, UIImageOrientation.leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi/2)
            break
        case UIImageOrientation.right, UIImageOrientation.rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -CGFloat.pi/2)
            break
        case UIImageOrientation.up, UIImageOrientation.upMirrored:
            break
        }
        
        switch imageOrientation {
        case UIImageOrientation.upMirrored, UIImageOrientation.downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case UIImageOrientation.leftMirrored, UIImageOrientation.rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case UIImageOrientation.up, UIImageOrientation.down, UIImageOrientation.left, UIImageOrientation.right:
            break
        }
        
        let ctx: CGContext = CGContext(data: nil,
                                       width: Int(size.width),
                                       height: Int(size.height),
                                       bitsPerComponent: self.cgImage!.bitsPerComponent,
                                       bytesPerRow: 0,
                                       space: self.cgImage!.colorSpace!,
                                       bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case UIImageOrientation.left, UIImageOrientation.leftMirrored, UIImageOrientation.right, UIImageOrientation.rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        let cgImage: CGImage = ctx.makeImage()!
        
        return UIImage(cgImage: cgImage)
    }
    
}

