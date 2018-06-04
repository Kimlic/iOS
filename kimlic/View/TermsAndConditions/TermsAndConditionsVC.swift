//
//  TermsAndConditionsVC.swift
//  kimlic
//
//  Created by izzet öztürk on 31.05.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class TermsAndConditionsVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.alwaysBounceVertical = true
        self.scrollView.isDirectionalLockEnabled = true
    }
    
    @IBAction func acceptButtonPressed(_ sender: Any) {        
        UIUtils.navigateToPhoneNumber(self)
    }
    
    
}
