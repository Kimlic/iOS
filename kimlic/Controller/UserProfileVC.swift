//
//  UserProfileVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 14.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import UIKit
import SwiftyUserDefaults

class UserProfileVC: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var imgProfileImageFrame: UIImageView!
    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var imgAllPermissions: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgProfileLevel: UIImageView!
    @IBOutlet weak var imgProfileLevelChangeable: AnimatedImageView!
    @IBOutlet weak var imgScanCode: UIImageView!
    @IBOutlet weak var lblProfileLevel: UILabel!
    @IBOutlet weak var footerContainer: UIView!
    @IBOutlet weak var imgGreenTooltip: UIImageView!
    @IBOutlet weak var lblGreenTooltip: UILabel!
    @IBOutlet weak var viewGreenTooltip: UIView!
    @IBOutlet weak var btnCreatePhone: UIButton!
    
    let imagePicker = UIImagePickerController()
    var mediumImages = [UIImage]()
    var highImages = [UIImage]()
    var complateImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callEmailVerificateWebService()
        setLevelBarAnimationImage()
        
        imagePicker.delegate = self
        
        //sets the user interaction to true, so we can actually track when the image has been tapped
        imgProfileImageFrame.isUserInteractionEnabled = true
        imgAllPermissions.isUserInteractionEnabled = true
        imgScanCode.isUserInteractionEnabled = true
        
        //this is where we add the target, since our method to track the taps is in this class
        let recProfileImage = UITapGestureRecognizer()
        recProfileImage.addTarget(self, action: #selector(selectProfileImage))
        
        let recAllPermissions = UITapGestureRecognizer()
        recAllPermissions.addTarget(self, action: #selector(btnAllPermissionsPressed))
        
        let recScanCode = UITapGestureRecognizer()
        recScanCode.addTarget(self, action: #selector(scanCodePressed))
        
        //finally, this is where we add the gesture recognizer, so it actually functions correctly
        imgProfileImageFrame.addGestureRecognizer(recProfileImage)
        imgAllPermissions.addGestureRecognizer(recAllPermissions)
        imgScanCode.addGestureRecognizer(recScanCode)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
        //Profile level bar animation
        self.setUserProfileLevel(type: .show)
        
        Animz.fadeIn(image: imgProfileImage, duration: Animz.time06)
        Animz.fadeIn(image: imgProfileImageFrame, duration: Animz.time06)
        Animz.setMenuHide(myView: footerContainer)
        Animz.showMenu(myView: footerContainer, duration: Animz.time06){}
        
    }
    
    //Opens the camera when profile picture is clicked
    @objc func selectProfileImage() {
        
        guard  UIImagePickerController.isSourceTypeAvailable(.camera) else {
            PopupGenerator.createPopup(controller: self, type: .error, popup: Popup(title: "noCameraTitle".localized, message: "noCameraMessage".localized, buttonTitle: "noCameraButtonTitle".localized))
            return
        }
        //Camera settings are made
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //************** Image Selected Callback ***********************
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let myImageSize = CGSize(width: 559, height: 516)
        let resizeChosenImage: UIImage = chosenImage.resizeImage(size: myImageSize)
        dismiss(animated:true, completion: nil)
        
        let user = User(firstName: Defaults[.firstName], lastName: Defaults[.lastName], email: Defaults[.email], image: resizeChosenImage)
        
        
        // User Profile Image Update Web Service
        UIUtils.showLoading()
        UserWebServiceRequest().updateProfileImage(user: user) { (userUpdateResponse) in
            if userUpdateResponse != nil {                
                Animz.fadeOut(image: self.imgProfileImage, duration: Animz.time06, completion: {
                    self.imgProfileImage.image = resizeChosenImage.profileImageMask()
                    Defaults[.photoVerified] = true
                    Defaults[.photo] = resizeChosenImage.getImageData()
                    self.setUserProfileLevel(type: .create)
                    Animz.fadeIn(image: self.imgProfileImage, duration: Animz.time06)
                })
                UIUtils.stopLoading()
            }else {
                UIUtils.stopLoading()
                PopupGenerator.createPopup(controller: self, type: .error, popup: Popup())
            }
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    //****************************************************************
    @IBAction func btnPhoneNumberPressed(_ sender: Any) {
        if Defaults[.phoneVerified] == nil {
            UIUtils.navigateToPhoneNumber(self)
        }
    }
    
    //All Permissions Image Clicked
    @objc func btnAllPermissionsPressed() {
        Animz.hideMenu(myView: footerContainer, duration: Animz.time04){
            UIUtils.navigateToAllPermissionsFooter(vc: self){
                //ibrahim - footer set initial state. When user come from All Permission Screen, view will not recreate.
                Animz.setMenuShow(myView: self.footerContainer)
            }
        }
    }
    
    @objc func scanCodePressed() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            PopupGenerator.createPopup(controller: self, type: .error, popup: Popup(title: "noCameraTitle".localized, message: "noCameraMessage".localized, buttonTitle: "noCameraButtonTitle".localized))
            return
        }
        //If e-mail and phone number are not verified, a warning is given
        //Backplane email web service triggered
        guard let emailVerified = Defaults[.emailVerified], emailVerified else {
            PopupGenerator.createPopup(controller: self, type: .warning, popup: Popup())
            callEmailVerificateWebService()
            return
        }
        guard let phoneVerifed = Defaults[.phoneVerified], phoneVerifed else {
            PopupGenerator.createPopup(controller: self, type: .warning, popup: Popup())
            return
        }
        UIUtils.navigateToScanCode(vc: self)
    }
    
    @IBAction func logout(_ sender: Any) {        
        let popup = Popup()
        popup.title = "logoutTitle".localized
        popup.message = "logoutMessage".localized
        popup.buttonTitle = "logoutButtonTitle".localized
        popup.cancelButton = true
        PopupGenerator.createPopup(controller: self, type: .warning, popup: popup) {
            SystemUtils.logout(controller: self)  
        }
        
    }
    //user information is retrieved and set in fields
    func setUserProfileLevel(type: LevelBarAnimationType) {
        
        var verifiedCount = 0
        
        //Set user firstname and lastname
        lblUserName.text = SystemUtils.getFirstNameAndLastName()
        
        
        // email textfield set value and icon
        if let emailVerified = Defaults[.emailVerified], emailVerified {
            verifiedCount += 1
            txtEmailAddress.text = Defaults[.email]
            txtEmailAddress.greenCheckIcon()
        }else {
            if Defaults[.email] != nil {
                txtEmailAddress.warningIcon()
                txtEmailAddress.text = Defaults[.email]
            }else {
                txtEmailAddress.removeIcon()
            }
        }
        // phone textfield set value and icon
        if let phoneVerified = Defaults[.phoneVerified], phoneVerified {
            verifiedCount += 1
            txtPhoneNumber.text = SystemUtils.getCountryCodeAndPhoneNumber()
            txtPhoneNumber.greenCheckIcon()
        }else {
            if Defaults[.phone] != nil {
                txtPhoneNumber.warningIcon()
                txtPhoneNumber.text = Defaults[.phone]
            }else {
                txtPhoneNumber.removeIcon()
            }
        }
        // photo imageview set image
        if let photoVerified = Defaults[.photoVerified], photoVerified {
            verifiedCount += 1
            imgProfileImageFrame.image = UIImage(named: "profile_image_frame_green")
            if let imgData = Defaults[.photo] {
                imgProfileImage.image = UIImage(data: imgData, scale: 1.0)?.profileImageMask()
            }            
        }else {
            imgProfileImageFrame.image = UIImage(named: "add_image_frame")
        }
        switch verifiedCount {
        case 1:
            lblProfileLevel.text = "medium".localized
            lblProfileLevel.textColor = Constants.Colors.appOrange
            imgProfileLevelChangeable.levelBarAnimation(images: mediumImages, type: type)
            break
        case 2:
            lblProfileLevel.text = "high".localized
            lblProfileLevel.textColor = Constants.Colors.appGreen
            imgProfileLevelChangeable.levelBarAnimation(images: highImages, type: type)
            break
        case 3:
            lblProfileLevel.text = "complate".localized
            lblProfileLevel.textColor = Constants.Colors.appBlue
            txtEmailAddress.blueCheckIcon()
            txtPhoneNumber.blueCheckIcon()
            imgProfileImageFrame.image = UIImage(named: "profile_image_frame_blue")
            imgProfileLevelChangeable.levelBarAnimation(images: complateImages, type: type)
            break
        default:
            lblProfileLevel.text = "basic".localized
            lblProfileLevel.textColor = Constants.Colors.textGray
            break
        }        
        
    }
    
    //the level bar images are loaded when this page is opened for the first time
    func setLevelBarAnimationImage() {
        mediumImages.append(UIImage(named: "complete_transparent")!)
        mediumImages.append(UIImage(named: "medium_orange_level")!)
        highImages.append(UIImage(named: "complete_transparent")!)
        complateImages.append(UIImage(named: "complete_transparent")!)       
        
        for i in 1...2 {
            if let img = UIImage(named: "high_green_level\(i)") {
                 highImages.append(img)
            }
        }
        
        for i in 1...3 {
            if let imgComplate = UIImage(named: "complete_blue_level\(i)") {
                complateImages.append(imgComplate)
            }
        }
    }
    // update the relevant fields by checking from the web service that the email address is authenticated
    func callEmailVerificateWebService() {
        guard let emailVerified = Defaults[.emailVerified], emailVerified else {
            EmailWebServiceRequest().getEmail(completion: { (emailResponse) in
                if let verified = emailResponse?.verified, verified {
                    Defaults[.emailVerified] = true
                    self.setUserProfileLevel(type: .create)
                }
            })
            return
        }
    }
}
