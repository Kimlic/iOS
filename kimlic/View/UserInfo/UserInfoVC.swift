//
//  UserInfoVC.swift
//  kimlic
//
//  Created by izzet öztürk on 12.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class UserInfoVC: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set default display
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstNameTextField.text = Defaults[.firstName] ?? ""
        lastNameTextField.text = Defaults[.lastName] ?? ""
    }
    
    private func setupView() {
        saveButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.greenGradianteColors, frame: saveButton.frame, type: .topBottom).color
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if formControl() {
            Defaults[.firstName] = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            Defaults[.lastName] = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            UIUtils.navigateToMessage(self, messageType: .fullNameSuccessfull)
        }else {
            PopupGenerator.createPopup(controller: self, type: .warning, popup: Popup(title: "fieldsRequiredTitle".localized, message: "fieldsRequiredMessage".localized, buttonTitle: "fieldsRequiredButtonTitle".localized))
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func formControl() -> Bool {
        guard let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !firstName.isEmpty else {
            return false
        }
        guard let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !lastName.isEmpty else {
            return false
        }
        return true
    }
    
}
