//
//  ErrorHelper.swift
//  kimlic
//
//  Created by ibrahim özdemir on 13.07.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import Foundation

struct KimlicError: Error {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    public var localizedDescription: String {
        return message
    }
}
