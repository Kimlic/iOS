//
//  SignUpVC.swift
//  kimlic
//
//  Created by izzet öztürk on 31.05.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var newIdentityButton: UIButton!
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set default views
        setupView()
    }
    
    // MARK: - IBActions
    
    @IBAction func newIdentityButtonPressed(_ sender: Any) {
        UIUtils.navigateToTutorial(self)
    }
    
    @IBAction func recoverIdentityButtonPressed(_ sender: Any) {
        UIUtils.navigateToTerms(self, nextPage: .accountRecovery)
    }
    
    // MARK: - Functions
    
    private func setupView() {
        newIdentityButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.blueGradianteColors, frame: newIdentityButton.frame, type: .topBottom).color
    }
}
