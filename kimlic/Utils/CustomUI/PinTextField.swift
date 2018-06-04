//
//  PinTextField.swift
//  kimlic
//
//  Created by paltimoz on 4.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

protocol PinTexFieldDelegate : UITextFieldDelegate {
    func didPressBackspace(_ textField : PinTextField)
}

class PinTextField: UITextField {
    
    override func deleteBackward() {
        super.deleteBackward()
        
        // If conforming to our extension protocol
        if let pinDelegate = self.delegate as? PinTexFieldDelegate {
            pinDelegate.didPressBackspace(self)
        }
    }
}
