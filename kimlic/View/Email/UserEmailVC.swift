//
//  UserEmailVC.swift
//  kimlic
//
//  Created by paltimoz on 11.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let user = CoreDataHelper.getUser()
        emailTextField.text = user?.email
    }
    
    // MARK: - IBActions
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text, email.isEmail else { showEmailError("Invalid Email"); return }
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
        UIUtils.navigateToVerification(self, email: email)
//        UIUtils.showLoading()
//        CustomWebServiceRequest.createEmail(email: email, success: {
//            UIUtils.stopLoading()
//            UIUtils.navigateToVerification(self, email: email)
//        }) { (error) in
//            UIUtils.stopLoading()
//            self.showEmailError(error)
//        }
    }
    
    private func showEmailError(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            let popup = Popup(title: "Warning", message: message, image: #imageLiteral(resourceName: "email_with_circle"), buttonTitle: nil)
            PopupGenerator.baseCancelAlertPopup(controller: strongSelf, popup: popup)
        }
    }
}
