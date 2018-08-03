//
//  MnemonicImportVC.swift
//  kimlic
//
//  Created by izzet öztürk on 9.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit
import CloudCore

class MnemonicImportVC: UIViewController {

    @IBOutlet weak var passTextView: UITextView!
    @IBOutlet weak var verifyButton: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        passTextView.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func verifyButtonPressed(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        CloudCore.fetchAndSave(to: appDelegate.persistentContainer, error: nil) {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                UIUtils.navigateToMessage(strongSelf, messageType: .passMatchSuccessfull)
            }
        }
    }
    
    private func setupView() {
        passTextView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        verifyButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.greenGradianteColors, frame: verifyButton.frame, type: .topBottom).color
    }
    
    
}
