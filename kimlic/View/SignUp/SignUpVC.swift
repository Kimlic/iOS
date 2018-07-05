//
//  SignUpVC.swift
//  kimlic
//
//  Created by izzet öztürk on 31.05.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import Quorum


class SignUpVC: UIViewController {
    @IBOutlet weak var newIdentityButton: UIButton!
    @IBOutlet weak var logo: UIImageView!
    
    private lazy var accountStorageAdapterContract = AccountStorageAdapterContract()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set default views
        setupView()
    }
    
    private func setupView() {
        newIdentityButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.blueGradianteColors, frame: newIdentityButton.frame, type: .topBottom).color
        
    }
    
    private func setAccountFieldMainData() {
        do {
            _ = try accountStorageAdapterContract.setAccountFieldMainData()
        } catch let err {
            print("CATCH: ", err, "\n")
        }
    }
    
    @IBAction func newIdentityButtonPressed(_ sender: Any) {
        UIUtils.navigateToTutorial(self)
        //ibrahim - we should call this before phone or email verification
        setAccountFieldMainData()
    }
    
    @IBAction func recoverIdentityButtonPressed(_ sender: Any) {
        UIUtils.navigateToTerms(self, nextPage: .accountRecovery)
    }
}
