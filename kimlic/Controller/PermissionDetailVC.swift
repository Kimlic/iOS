//
//  PermissionDetailVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 16.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import UIKit
import SwiftyUserDefaults

class PermissionDetailVC: UIViewController {
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtMobilePhone: UITextField!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var imgBage: UIImageView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var btnTouchIdAccept: UIButton!
    var permission: PermissionDetailResponse!
    var qrCode: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnTouchIdAccept.titleLabel?.adjustsFontSizeToFitWidth = true
        btnTouchIdAccept.titleLabel?.minimumScaleFactor = 0.6
        
        setPageFieldsValue()
        setPermissionScope()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Animz.fadeIn(image: imgBage, duration: Animz.time06)
        Animz.fadeIn(image: imgLogo, duration: Animz.time06)
    }
    @IBAction func btnBack(_ sender: Any) {     
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func btnTouchIDAcceptPressed(_ sender: Any) {
        guard Defaults[.passcode] != nil else {
//            UIUtils.presentVerificationCodeVC(vc: self, pageType: .verificate, qrCode: self.qrCode)
            return
        }
//        UIUtils.confirmTouchID(controller: self, targetController: .UserProfileVC, qrCode: self.qrCode)
    }
    
    func setPageFieldsValue() {
        
        if Defaults[.passcode] != nil {
            btnTouchIdAccept.setImage(nil, for: .normal)
            btnTouchIdAccept.setTitle("enterCodeAccept".localized, for: .normal)
        }
        
        txtTitle.text = permission.name
        txtEmailAddress.text = Defaults[.email]
        txtEmailAddress.greenCheckIcon()
        
        txtMobilePhone.text = SystemUtils.getCountryCodeAndPhoneNumber()
        txtMobilePhone.greenCheckIcon()
        
        var bageName = "ID_badge_"
        if permission.theme != nil {
            bageName += permission.theme!
            if let img = UIImage(named: bageName) {
                imgBage.image = img
            }
        }
        imgLogo.downloadedFrom(link: permission.avatarUrl)
    }
    
    func setPermissionScope() {
        
        permission.scopes?.forEach({ (value) in
            
            switch value {
            case Constants.PermissionScope.Emails:
                txtEmailAddress.isHidden = false
                break
            case Constants.PermissionScope.Phones:
                txtMobilePhone.isHidden = false
                break
            case Constants.PermissionScope.Profile:
                break
            default:
                break
            }            
        })
    }    
}
