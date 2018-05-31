//
//  AnimatedImageViewExt.swift
//  kimlic
//
//  Created by İzzet Öztürk on 1.12.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import Foundation
import UIKit

extension AnimatedImageView {   
    func levelBarAnimation(images: [UIImage], type: LevelBarAnimationType) {        
        if type == .create {
            if let oldImages = self.animationImages {
                var newList = [UIImage]()
                newList = oldImages.reversed()
                self.image = newList.last
                self.animationImages = newList
                self.animationDuration = 0.6
                self.animationRepeatCount = 1
                self.startAnimate(completion: { (finished) in
                    self.image = images.last
                    self.animationImages = images
                    self.animationDuration = 0.6
                    self.animationRepeatCount = 1
                    self.startAnimating()
                })
                return
            }
        }
        self.image = images.last
        self.animationImages = images
        self.animationDuration = 0.6
        self.animationRepeatCount = 1
        self.startAnimating()
        return
    }
    
    
}
