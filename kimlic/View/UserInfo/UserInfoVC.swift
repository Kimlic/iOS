//
//  UserInfoVC.swift
//  kimlic
//
//  Created by izzet öztürk on 12.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var saveButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set default display
        setupView()
    }
    
    private func setupView() {
        saveButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.greenGradianteColors, frame: saveButton.frame, type: .topBottom).color
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if formControl() {
            print("Form succes save")
        }else {
            print("Form valid")
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
