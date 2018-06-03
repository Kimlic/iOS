//
//  Country.swift
//  kimlic
//
//  Created by paltimoz on 4.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import Foundation

struct Country {
    private(set) var code: String
    private(set) var name: String
    
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}
