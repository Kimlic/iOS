//
//  ProfileVC.swift
//  kimlic
//
//  Created by izzet öztürk on 11.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PopupGenerator.createPopupNew(controller: self, type: .security, popup: Popup())
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        UIUtils.navigateToSettings(self)
    }
    
    //Opens the camera when profile picture is clicked
    @IBAction func addPhotoButtonPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //Camera settings are made
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            PopupGenerator.createPopup(controller: self, type: .error, popup: Popup(title: "noCameraTitle".localized, message: "noCameraMessage".localized, buttonTitle: "noCameraButtonTitle".localized))
            return
        }
        
    }
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let myImageSize = CGSize(width: 559, height: 516)
        let resizeChosenImage: UIImage = chosenImage.resizeImage(size: myImageSize)
        profileImage.image = resizeChosenImage.profileImageMask()
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

class BodyTableVC: UITableViewController {
    
    
    @IBOutlet var bodyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: bodyTableView.frame.size.width, height: 50))
        footerView.backgroundColor = UIColor.clear
        bodyTableView.tableFooterView = footerView
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0: // first name, last name page
            if Defaults[.firstName] != nil, Defaults[.lastName] != nil {
                cell.textLabel?.text = "\(Defaults[.firstName]!) \(Defaults[.lastName]!)"
            }else {
                cell.textLabel?.text = "Add your name"
            }
        case 1: // security status
            cell.textLabel?.text = "You have 2 Security"
        case 2: // balance
            cell.textLabel?.text = "Balance 3 KIM"
        case 3: // phone number
            cell.textLabel?.text = Defaults[.phone] ?? "Add your phone"
        case 4: // email
            cell.textLabel?.text = Defaults[.email] ?? "Add your email"
        default:
            print("Add your full name")
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
        default:
            print("Add your full name")
        }
    }
    
}
