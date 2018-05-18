//
//  User.swift
//  CustomTabBar
//
//  Created by İzzet Öztürk on 23.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import Foundation
import UIKit

public class User {
    
    var firstName: String?
    var lastName: String?
    var email: String?
    var image: UIImage?
    
    
    init(firstName: String?, lastName: String?, email:String?, image: UIImage?) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.image = image
    }
    
}

