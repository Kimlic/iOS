//
//  MnemonicImportVC.swift
//  kimlic
//
//  Created by izzet öztürk on 9.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class MnemonicImportVC: UIViewController {

    @IBOutlet weak var passTextView: CustomTextView!
    @IBOutlet weak var verifyButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        passTextView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        verifyButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.blueGradianteColors, frame: verifyButton.frame, type: .topBottom).color
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func verifyButtonPressed(_ sender: Any) {
        UIUtils.navigateToMessage(self, message: Constants.StaticMessage.passMatchSuccessfull)
    }
    
    
}
