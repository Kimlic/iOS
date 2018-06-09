//
//  UserEmailAdressVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 14.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import UIKit
import SwiftyUserDefaults

class UserBasicProfileInfoVC: UIViewController {
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var imgHexagon: UIImageView!
    @IBOutlet weak var imgHexagonContent: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSave.backgroundColor = Constants.Colors.appBlue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Animz.fadeIn(image: imgHexagonContent, duration: Animz.time06)
        Animz.fadeIn(image: imgHexagon, duration: Animz.time06)
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSavePressed(_ sender: Any) {
        formControl()
    }
    @IBAction func txtFirstNameEndEditing(_ sender: Any) {
        txtLastName.becomeFirstResponder()
    }
    
    @IBAction func txtLastNameEndEditing(_ sender: Any) {
        txtEmailAddress.becomeFirstResponder()
    }    
    @IBAction func txtEmailEndEditing(_ sender: Any) {
    }
    
    //User save and get user token
    func saveUser (firstName: String, lastName: String, email: String) {
        
        UIUtils.showLoading()
        let user = User(firstName: firstName, lastName: lastName, email: email, image: nil)
        
        UserWebServiceRequest().createUser(user: user, completion: { (userCreateResponse) in
            if userCreateResponse != nil {
                
                TokenWebServiceRequest().resourceOwnerRequest(walletAddress: userCreateResponse?.walletAddress, privateKey: userCreateResponse?.privateKey, completion: { (tokenResponse) in
                    if tokenResponse != nil && tokenResponse?.accessToken != nil{
                        Defaults[.userToken] = tokenResponse?.accessToken
                        Defaults[.firstName] = firstName
                        Defaults[.lastName] = lastName
                        Defaults[.email] = email
                        UIUtils.stopLoading()
                        let _ = UIUtils.setUserProfileScreenAsRoot()
                    }else {
                        UIUtils.stopLoading()
                        PopupGenerator.createPopup(controller: self, type: .error, popup: Popup())
                    }
                })
            }else {
                UIUtils.stopLoading()
                PopupGenerator.createPopup(controller: self, type: .error, popup: Popup())
            }
        })
        
    }
    
    // Form fields emty control and valid email control
    func formControl() {
        
        let firstName = txtFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = txtLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = txtEmailAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !firstName!.isEmpty, !lastName!.isEmpty, !email!.isEmpty ,SystemUtils.isValidEmail(email: txtEmailAddress?.text) else {
            PopupGenerator.createPopup(controller: self, type: .warning, popup: Popup(title: "fieldsRequiredTitle".localized, message: "fieldsRequiredMessage".localized, buttonTitle: "fieldsRequiredButtonTitle".localized))
            return
        }
        self.saveUser(firstName: firstName!, lastName: lastName!, email: email!)
    }    
}
