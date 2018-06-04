//
//  Message.swift
//  kimlic
//
//  Created by izzet öztürk on 4.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit


struct Message {
    var icon: UIImage
    var title: String
    var desc: String
    
    init(icon: UIImage, title: String, desc: String) {
        self.icon = icon
        self.title = title
        self.desc = desc
    }
}
