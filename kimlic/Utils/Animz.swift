//
//  Animz.swift
//  kimlic
//
//  Created by ibrahim özdemir on 18.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import UIKit

public class Animz: UIView{
    static var time08:Double = 0.8
    static var time06:Double = 0.6
    static var time04:Double = 0.4
    static var time03:Double = 0.2
    static var time02:Double = 0.2
    
    private static var imgProfileNewID: UIImageView!
    private static var lblProfileNewID: UILabel!
    private static var viewNewID: UIView!
    
    static func newScreenAddedAnimation(controller: UserProfileVC!) {
        
        self.imgProfileNewID = controller.imgGreenTooltip
        self.lblProfileNewID = controller.lblGreenTooltip
        self.viewNewID = controller.viewGreenTooltip
        
        controller.viewGreenTooltip.isHidden = false
        
        imgProfileNewID.alpha = 0
        imgProfileNewID.transform = CGAffineTransform(scaleX: 0, y: 0)
        lblProfileNewID.alpha = 0
        lblProfileNewID.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animate(withDuration: 0.5, animations: {
            imgProfileNewID.alpha = 1
            imgProfileNewID.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            lblProfileNewID.alpha = 1
            lblProfileNewID.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            
        }) { (finished) in
            UIView.animate(withDuration: 0.1, animations: {
                imgProfileNewID.alpha = 1
                imgProfileNewID.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                lblProfileNewID.alpha = 1
                lblProfileNewID.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                
            }, completion: { (finis) in
                
                Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(closeScreenAddedPopup), userInfo: nil, repeats: false)
            })
        }
    }
    
    @objc static func closeScreenAddedPopup() {
        UIView.animate(withDuration: 0.1, animations: {
            Animz.imgProfileNewID.alpha = 1
            Animz.imgProfileNewID.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            Animz.lblProfileNewID.alpha = 1
            Animz.lblProfileNewID.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { (finis) in
            UIView.animate(withDuration: 0.5, animations: {
                Animz.imgProfileNewID.alpha = 0
                Animz.imgProfileNewID.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                Animz.lblProfileNewID.alpha = 0
                Animz.lblProfileNewID.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }, completion: { (f) in
                Animz.viewNewID.isHidden = true
            })
        })
    }
    static func fadeIn(image: UIImageView!, duration: Double, completion: (() -> ())? = nil) {
        
        image.alpha = 0.0
        image.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: duration, animations: {
            image.alpha = 1.0
            image.transform = CGAffineTransform.identity
        }, completion: { finished in
            completion?()
        })
        
    }
    
    static func fadeOut(image: UIImageView!, duration: Double, completion: (() -> ())? = nil) {
        
        image.alpha = 1.0
        image.transform = CGAffineTransform.identity
        
        UIView.animate(withDuration: duration, animations: {
            image.alpha = 0.0
            image.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }, completion: { finished in
            completion?()
        })
    }
    
    static func rotateY(layer:CALayer, angleFrom:Int,duration: Double, completion: @escaping() -> ()){
        //ibrahim - solving half hiding layer
        layer.zPosition = 100;
        
        CATransaction.begin()
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotationAnimation.fromValue = CGFloat(angleFrom) * CGFloat(Double.pi / 180)
        rotationAnimation.toValue = 0
        let innerAnimationDuration : CGFloat = CGFloat( duration )
        rotationAnimation.duration = Double(innerAnimationDuration)
        rotationAnimation.repeatCount = 1
        
        // Callback function
        CATransaction.setCompletionBlock {
            completion()
        }
        layer.add(rotationAnimation, forKey: "rotateInner")
        CATransaction.commit()
    }
    
    static func showMenu(myView:UIView, duration: Double, completion: @escaping() -> ()){
        //ibrahim - animasyonla ekrana getiriyoruz.
        UIView.animate(withDuration: duration, animations: {
            var myViewFrame = myView.frame
            myViewFrame.origin.y -= myViewFrame.size.height
            myView.frame = myViewFrame
        }, completion: { finished in
            completion()
        })
    }
    
    static func hideMenu(myView:UIView, duration: Double, completion: @escaping() -> ()){
        //ibrahim - animasyonla asagi kaydiriyoruz.
        UIView.animate(withDuration: duration , animations: {
            var myViewFrame = myView.frame
            myViewFrame.origin.y += myViewFrame.size.height
            myView.frame = myViewFrame
        }, completion: { finished in
            completion()
        })
    }
    
    static func setMenuShow(myView:UIView){
        var footerInitialFrame = myView.frame
        footerInitialFrame.origin.y -= footerInitialFrame.size.height
        myView.frame = footerInitialFrame
    }
    
    static func setMenuHide(myView:UIView){
        var footerInitialFrame = myView.frame
        footerInitialFrame.origin.y += footerInitialFrame.size.height
        myView.frame = footerInitialFrame
    }
}
