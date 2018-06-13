//
//  ProfileVC.swift
//  kimlic
//
//  Created by izzet öztürk on 11.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageFrame: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        UIUtils.navigateToSettings(self)
    }
    
    //Opens the camera when profile picture is clicked
    @IBAction func selectProfileImage(_ sender: Any) {
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
        profileImageFrame.image = #imageLiteral(resourceName: "profile_image_frame_blue")
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
        
        bodyTableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.disclosureIndicatorColor = UIColor.red
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: // first name, last name page
            UIUtils.navigateToUserInfo(self)
        case 1: // user phone number page
            UIUtils.navigateToPhoneNumber(self)
        case 2: // user email page
            UIUtils.navigateToEmail(self)
        case 3: // verify ID
            print("Add verify ID")
        default:
            print("Add your full name")
        }
    }
    
}
