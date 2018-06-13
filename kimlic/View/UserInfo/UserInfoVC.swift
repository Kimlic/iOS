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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
