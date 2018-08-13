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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func verifyButtonPressed(_ sender: Any) {
        UIUtils.showLoading()
        createQuorum {
            UIUtils.stopLoading()
        }
    }
    
    // MARK: - Functions
    
    private func setupView() {
        passTextView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        verifyButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.greenGradianteColors, frame: verifyButton.frame, type: .topBottom).color
    }
    
    // Create qurom for mnemonic pass.
    private func createQuorum(completion: @escaping () -> ()) {
        
        appDelegate.createQuorum(mnemonic: passTextView.text) {
            if self.appDelegate.quorumManager != nil {
                self.coreDataFetchAndSave(completion: completion)
            } else {
                // TODO: Wrong mnemonic popup
                completion()
                print("Wrong Mnemonic Passphrase")
            }
        }
    }
    
    // Core data sync cloud kit
    private func coreDataFetchAndSave(completion: @escaping () -> ()) {
        CloudCore.fetchAndSave(to: appDelegate.persistentContainer, error: nil) {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                UIUtils.navigateToMessage(strongSelf, messageType: .passMatchSuccessfull)
            }
            completion()
        }
    }
    
}
