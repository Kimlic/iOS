//
//  UserEmailVC.swift
//  kimlic
//
//  Created by paltimoz on 11.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import web3swift
import Alamofire

class UserEmailVC: UIViewController {
    
    // MARK: - Variables
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    private lazy var accountStorageAdapterManager = AccountStorageAdapterManager()
    
    // MARK: - Life
    
    override func loadView() {
        super.loadView()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = Defaults[.email]
    }
    
    // MARK: - IBActions
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text, email.isEmail else { showEmailError(); return }
        serverRequest(email)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private
    
    private func setupView() {
        nextButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.blueGradianteColors, frame: nextButton.frame, type: .topBottom).color
    }
    
    private func serverRequest(_ email: String) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let strongSelf = self else { return }
            do {
                guard let quorumAddress = strongSelf.accountStorageAdapterManager.quorumManager.accountAddress() else { fatalError("No quorum address found") }
                let result = try strongSelf.accountStorageAdapterManager.setAccountFieldMainData(type: .email, value: email)
                guard let receipt = result["receipt"] as? TransactionReceipt, receipt.status == .ok else { strongSelf.showEmailError(); return }
                
                guard let response = Alamofire.request(
                    "http://mobile-api-dev.kimlic.com/api/verifications/email",
                    method: .post,
                    parameters: ["email": email],
                    encoding: URLEncoding.queryString,
                    headers: ["account-address": quorumAddress.lowercased(), "content-type": "application/json"])
                    .responseJSON().value as? [String: [String: AnyObject]] else { strongSelf.showEmailError(); return }
                guard let code = response["meta"]?["code"] as? Int, code == 201 else { strongSelf.showEmailError(); return }
                
                DispatchQueue.main.async {
                    UIUtils.navigateToVerification(strongSelf, email: email)
                }
            } catch _ {
                strongSelf.showEmailError()
            }
        }
    }
    
    private func showEmailError() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            PopupGenerator.createPopup(controller: strongSelf, type: .warning, popup: Popup(title: "Wrong", message: "Wrong Email Address", buttonTitle: "Try! AGAIN"))
        }
    }
}
