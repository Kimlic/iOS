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
    
    private lazy var configCustom = Web3Config(scheme: "http", host: "127.0.0.1", port: 22000, path:"/api/proxy", networkId: 10)
    //    private lazy var configLocal = Web3ParamsLocalhost()
    private lazy var quorumManager = Quorum(configCustom)
    private lazy var accountStorageAdapter = AccountStorageAdapter(address: "0xd63a61238cfc86db6dbb4ab4484f33b3d56b249c")

    

    @IBOutlet weak var newIdentityButton: UIButton!
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set default views
        setupView()
        
        quorum()
    }
    
    private func quorum() {
        let mnemonic = try! Quorum.mnemonic()
        print("MNEMONIC: ", mnemonic, "\n")
        try! Quorum.keystoreWith(mnemonic: mnemonic)
        
        do {
            let receiptSet = try quorumManager.send(contract: accountStorageAdapter, method: accountStorageAdapter.transactions.setAccountFieldMainData,
                                                    params: ["8C16561DFE998D2811A4BC8A2E97693526847D522E14FB5D20A5BA09F10F1902", quorumManager.accountAddress()!])
            print("RECEIPT SET: ", receiptSet, "\n")
        } catch let err {
            print("CATCH: ", err, "\n")
        }
    }
    
    private func setupView() {
        newIdentityButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.blueGradianteColors, frame: newIdentityButton.frame, type: .topBottom).color
        
    }
    
    @IBAction func newIdentityButtonPressed(_ sender: Any) {
        UIUtils.navigateToTutorial(self)
    }
    
    @IBAction func recoverIdentityButtonPressed(_ sender: Any) {
        UIUtils.navigateToTerms(self, nextPage: .accountRecovery)
    }
}
