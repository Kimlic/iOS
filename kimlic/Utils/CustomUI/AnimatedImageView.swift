//
//  AnimatedImageView.swift
//  kimlic
//
//  Created by İzzet Öztürk on 1.12.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import UIKit


//ImageView Animation Complate
class AnimatedImageView: UIImageView, CAAnimationDelegate {
    
    var completion: ((_ completed: Bool) -> Void)?
    
    func startAnimate(completion: ((_ completed: Bool) -> Void)?) {
        self.completion = completion
        if let animationImages = animationImages {
            let cgImages = animationImages.map({ $0.cgImage as AnyObject })
            let animation = CAKeyframeAnimation(keyPath: "contents")
            animation.values = cgImages
            animation.repeatCount = Float(self.animationRepeatCount)
            animation.duration = self.animationDuration
            animation.delegate = self
            
            self.layer.add(animation, forKey: nil)
        } else {
            self.completion?(false)
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        completion?(flag)
    }
}
