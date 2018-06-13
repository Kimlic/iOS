//
//  SettingsVC.swift
//  kimlic
//
//  Created by paltimoz on 10.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

class SettingsTableVC: UITableViewController {
    
    @IBOutlet weak var warningIconPasscode: UIImageView!
    @IBOutlet weak var warningIconAccount: UIImageView!
    @IBOutlet weak var warningIconTouchID: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        if let warningIcon = cell.viewWithTag(100) as? UIImageView, let switchButton = cell.viewWithTag(101) as? UISwitch {
            warningIcon.isHidden = switchButton.isOn
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 3:
            UIUtils.navigateToTerms(self, nextPage: .none)
        case 4:
            print("About Kimlic Clicked")
        default:
            break
        }
    }
    
    @IBAction func touchIDSwitchChange(_ sender: UISwitch) {
        warningIconTouchID.isHidden = sender.isOn
    }
    
    @IBAction func accountSwitchChange(_ sender: UISwitch) {
        warningIconAccount.isHidden = sender.isOn
    }
    
    @IBAction func passcodeSwitchChange(_ sender: UISwitch) {
        warningIconPasscode.isHidden = sender.isOn
    }
    
    
}
