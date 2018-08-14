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
  
    func cropImage(toRect cropRect: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) -> UIImage? {
        
        let scaleWidth = size.width / viewWidth
        let scaleHeight = size.height / viewHeight
        
        // Scale cropRect to handle images larger than shown-on-screen size
        let cropZone = CGRect(x: cropRect.origin.x * scaleWidth,
                              y: cropRect.origin.y * scaleHeight,
                              width: cropRect.size.width * scaleWidth,
                              height: cropRect.size.height * scaleHeight)
        
        // Perform cropping in Core Graphics
        guard let cutImageRef: CGImage = fixedOrientation()?.cgImage?.cropping(to:cropZone)
            else {
                return nil
        }
        
        // Return image to UIImage
        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        return croppedImage
    }
    
    func fixedOrientation() -> UIImage? {
        
        guard imageOrientation != UIImageOrientation.up else {
            //This is default orientation, don't need to do anything
            return self.copy() as? UIImage
        }
        
        guard let cgImage = self.cgImage else {
            //CGImage is not available
            return nil
        }
        
        guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil //Not able to create CGContext
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
            break
        case .up, .upMirrored:
            break
        }
        
        //Flip image one more time if needed to, this is to prevent flipped image
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        }
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up)
    }
    
}

