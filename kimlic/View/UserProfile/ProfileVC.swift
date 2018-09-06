//
//  ProfileVC.swift
//  kimlic
//
//  Created by izzet öztürk on 11.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileImage: UIImageView!
    
    // MARK: - Local Varibles
    var user: KimlicUser?
    var securityRiskCount = 0
    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get user data
        user = CoreDataHelper.getUser()
        
        controlRisks()
        setupView()
    }
    
    // MARK: - IBActions
    
    @IBAction func scanButtonPressed(_ sender: Any) {
        UIUtils.navigateToQRCode(self)
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        UIUtils.navigateToSettings(self)
    }
    
    //Opens the camera when profile picture is clicked
    @IBAction func addPhotoButtonPressed(_ sender: Any) {
        UIUtils.navigateToProfileCamera(self)
    }
    
    @IBAction func accountsButtonPressed(_ sender: Any) {
        UIUtils.navigateToAccounts(self)
    }
    
    // MARK: - Functions
    private func controlRisks() {
        if user?.passcode == nil && (user?.accountRecovery == nil || !(user?.accountRecovery)!){
            securityRiskCount = 2
            PopupGenerator.twoRisks(controller: self)
        }else if user?.passcode == nil{
            securityRiskCount = 1
            PopupGenerator.passcodeRisk(controller: self)
        }else if user?.accountRecovery == nil || !(user?.accountRecovery)! {
            securityRiskCount = 1
            PopupGenerator.recoveryRisk(controller: self)
        }
    }
    
    private func setupView() {
        guard let photoData = user?.profilePhoto, let photo = UIImage(data: photoData) else {
            return
        }
        profileImage.image = photo.profileImageMask()
    }
}

class BodyTableVC: UITableViewController {
    
    @IBOutlet var bodyTableView: UITableView!
    
    var user: KimlicUser?
    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: bodyTableView.frame.size.width, height: 50))
        footerView.backgroundColor = UIColor.clear
        bodyTableView.tableFooterView = footerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get user data
        user = CoreDataHelper.getUser()
        bodyTableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0: // first name, last name page
            if let firstName = user?.firstName, let lastName = user?.lastName {
                cell.textLabel?.text = "\(firstName) \(lastName)"
            }else {
                cell.textLabel?.text = "Add your name"
            }
        case 1: // security status
            cell.textLabel?.text = "You have 2 Security Risk"
        case 2: // balance
//            let balance = try! appDelegate.quorumManager?.quorum.accountBalance()
//            cell.textLabel?.text = "Balance \(balance) KIM"
            cell.textLabel?.text = "Balance 3 KIM"
        case 3: // phone number
            cell.textLabel?.text = user?.phone ?? "Add your phone"
        case 4: // email
            cell.textLabel?.text = user?.email ?? "Add your email"
        case 6: // address
            cell.textLabel?.text = user?.address ?? "Add your address"
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: // first name, last name page
            UIUtils.navigateToUserInfo(self)
        case 1: // security status
            print("Security Status")
        case 2: // balance
            print("Balance Status")
        case 3: // phone number
            UIUtils.navigateToPhoneNumber(self)
        case 4: // email
            UIUtils.navigateToEmail(self)
        case 5: // verify id
            UIUtils.navigateToVerifyIDFace(self)
        case 6: // address
            UIUtils.navigateToAddress(self)
        default:
            print("Add your full name")
        }
    }
    
}
