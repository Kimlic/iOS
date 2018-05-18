//
//  Popup.swift
//  kimlic
//
//  Created by İzzet Öztürk on 16.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import UIKit


class Popup {
    
    var title: String?
    var message: String?
    var image: UIImage?
    var buttonTitle: String?
    var cancelButton: Bool?
    
    init() {}
    
    init(title: String?, message: String?, image: UIImage?, buttonTitle: String?) {
        self.title = title
        self.message = message
        self.image = image
        self.buttonTitle = buttonTitle
    }
    
    
    
    init(title: String?, message: String?, buttonTitle: String?) {
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    
}

