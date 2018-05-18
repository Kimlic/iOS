//
//  ButtonCustomize.swift
//  kimlic
//
//  Created by İzzet Öztürk on 16.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21)
        self.frame.size.height = 50
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
        self.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20)
    }    
    
    //Image left aligment
    override func layoutSubviews() {
        super.layoutSubviews()
        contentHorizontalAlignment = .left
        let availableSpace = UIEdgeInsetsInsetRect(bounds, contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.right - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: availableWidth / 2, bottom: 0, right: 0)
    }
    
    
}
