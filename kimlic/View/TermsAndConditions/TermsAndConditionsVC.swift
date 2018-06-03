//
//  TermsAndConditionsVC.swift
//  kimlic
//
//  Created by izzet öztürk on 31.05.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class TermsAndConditionsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func acceptButtonPressed(_ sender: Any) {        
        UIUtils.navigateToPhoneNumber(self)
    }
    
    
}
