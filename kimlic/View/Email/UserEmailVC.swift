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
    
//    private lazy var accountStorageAdapterManager = AccountStorageAdapterManager()
    
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        do {
            let result = try appDelegate.quorumAPI?.setAccountFieldMainData(type: QuorumAPI.AccountFieldMainType.email, value: email)
            print("RES: \(result)")
            guard let receipt = result!["receipt"] as? TransactionReceipt, receipt.status == .ok else { showEmailError(); return }
            
            let url = Constants.APIEndpoint.emailVerification.url()
            let headers = ["account-address": appDelegate.quorumManager!.accountAddress.lowercased()]
            let params =  ["email": email]
            let response = Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.queryString, headers: headers)
                .responseJSON().value
            
            guard let json = response as? [String: [String: AnyObject]] else { showEmailError(); return }
            guard let code = json["meta"]?["code"] as? Int, code == 201 else { showEmailError(); return }
            
            UIUtils.navigateToVerification(self, email: email)
        } catch _ {
            showEmailError()
        }
    }
    
    private func showEmailError() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            PopupGenerator.createPopup(controller: strongSelf, type: .warning, popup: Popup(title: "Wrong", message: "Wrong Email Address", buttonTitle: "Try! AGAIN"))
        }
    }
}
