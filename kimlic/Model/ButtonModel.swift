//
//  ButtonModel.swift
//  kimlic
//
//  Created by ibrahim özdemir on 9.07.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import Foundation

struct ButtonModel {
    var tag: Int
    var title: String
    init(tag: Int, title: String) {
        self.tag = tag
        self.title = title
    }
}
