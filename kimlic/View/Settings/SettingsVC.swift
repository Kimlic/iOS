//
//  SettingsVC.swift
//  kimlic
//
//  Created by paltimoz on 10.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var deleteIdentityButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default display
        setupView()
    }
    
    private func setupView() {
        signOutButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.blueGradianteColors, frame: signOutButton.frame, type: .topBottom).color
        deleteIdentityButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.orangeGradianteColors, frame: deleteIdentityButton.frame, type: .topBottom).color
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteIdentityButtonPressed(_ sender: Any) {
        CoreDataHelper.delete(kimlicUser: CoreDataHelper.getUser()!)
        CoreDataHelper.destroy()
        appDelegate.quorumManager = nil
        let _ = UIUtils.setSignUpScreenAsRoot()
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        CoreDataHelper.destroy()
        appDelegate.quorumManager = nil
        let _ = UIUtils.setSignUpScreenAsRoot()
    }
}

class SettingsTableVC: UITableViewController {
    
    @IBOutlet weak var warningIconPasscode: UIImageView!
    @IBOutlet weak var warningIconAccount: UIImageView!
    @IBOutlet weak var warningIconTouchID: UIImageView!
    @IBOutlet var settingsTableView: UITableView!
    
    var user: KimlicUser?
    var isTouchID: Bool = false
    var isPassCode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get user data
        user = CoreDataHelper.getUser()
        settingsTableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        if let passWarning = cell.viewWithTag(100) as? UIImageView, let passSwitch = cell.viewWithTag(101) as? UISwitch {
            let passcodeIsActive = user?.passcode != nil ? true : false
            passSwitch.setOn(passcodeIsActive , animated: true)
            passWarning.isHidden = passSwitch.isOn
        }
        if let recoveryWarning = cell.viewWithTag(102) as? UIImageView {
            let recoveryIsActive = user?.accountRecovery ?? false
            recoveryWarning.isHidden = recoveryIsActive
        }
        if let touchIDWarning = cell.viewWithTag(104) as? UIImageView, let touchIDSwitch = cell.viewWithTag(105) as? UISwitch {
            let touchIDIsActive = user?.touchID ?? false
            touchIDSwitch.setOn(touchIDIsActive, animated: true)
            touchIDWarning.isHidden = touchIDSwitch.isOn
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            UIUtils.navigateToMnemonicCreate(self)
        case 3:
            UIUtils.navigateToTerms(self, nextPage: .none)
        case 4:
            print("About Kimlic Clicked")
        default:
            break
        }
    }
    
    @IBAction func touchIDSwitchChange(_ sender: UISwitch) {
        isTouchID = sender.isOn
        warningIconTouchID.isHidden = isTouchID
        UIUtils.navigateToTouchID(self) { (touchIDVC) in
            CoreDataHelper.saveTouchID(isTouchID: self.isTouchID)
            UIUtils.navigateToMessage(touchIDVC, messageType: .touchIDSuccessfull)            
        }
    }
    
    @IBAction func passcodeSwitchChange(_ sender: UISwitch) {
        warningIconPasscode.isHidden = sender.isOn
        if sender.isOn {
            UIUtils.showPasscodeVC(vc: self, pageType: .create) {
                self.settingsTableView.reloadData()
            }
        }else {
            UIUtils.showPasscodeVC(vc: self, pageType: .delete) {
                self.settingsTableView.reloadData()
            }
        }
    }
}
