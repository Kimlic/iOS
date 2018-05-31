//
//  AllPermissionsVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 15.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import UIKit
import Foundation
import FSPagerView
import SwiftyUserDefaults

class AllPermissionsVC: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UIGestureRecognizerDelegate, FSPagerViewDelegate, FSPagerViewDataSource {
    
    @IBOutlet weak var btnProfile: UIImageView!
    @IBOutlet weak var footerContainer: UIView!
    @IBOutlet weak var imgScanCode: UIImageView!
    
    @IBOutlet weak var collectionContainer: FSPagerView! {
        didSet {
            let nib = UINib(nibName: "PermissionCell", bundle: nil)
            self.collectionContainer.register(nib,forCellWithReuseIdentifier: "PermissionCell")
        }
    }
    
    var allPermissions = [PermissionDetailResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAllPermissionsList()
        
        //sets the user interaction to true, so we can actually track when the image has been tapped
        imgScanCode.isUserInteractionEnabled = true
        let recScanCode = UITapGestureRecognizer()
        recScanCode.addTarget(self, action: #selector(scanCodePressed))
        imgScanCode.addGestureRecognizer(recScanCode)
        
        btnProfile.isUserInteractionEnabled = true
        let recProfile = UITapGestureRecognizer()
        recProfile.addTarget(self, action: #selector(openProfilePage))
        btnProfile.addGestureRecognizer(recProfile)
        
        collectionContainer.dataSource = self
        collectionContainer.delegate = self
        
        collectionContainer.itemSize = CGSize(width: 280, height: 460)
        collectionContainer.interitemSpacing = 10
        collectionContainer.transformer = FSPagerViewTransformer(type: .linear)
        
    }
    
    @objc func scanCodePressed() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            let popup = Popup(title: "noCameraTitle".localized, message: "noCameraMessage".localized, image: nil, buttonTitle: "noCameraButtonTitle".localized)
            PopupGenerator.createPopup(controller: self, type: .error, popup: popup)
            return
        }
        guard let emailVerified = Defaults[.emailVerified], emailVerified,
            let phoneVerifed = Defaults[.phoneVerified], phoneVerifed  else{
                PopupGenerator.createPopup(controller: self, type: .warning, popup: Popup())
                return
        }
        UIUtils.navigateToScanCode(vc: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        Animz.setMenuHide(myView: footerContainer)
        Animz.showMenu(myView: footerContainer, duration: Animz.time06){}
        
    }
    
    @objc func openProfilePage() {
        Animz.hideMenu(myView: footerContainer, duration: Animz.time04){
            UIUtils.navigateToUserProfileFooter(vc: self)
        }
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return allPermissions.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = collectionContainer.dequeueReusableCell(withReuseIdentifier: "PermissionCell", at: index) as! PermissionCell
        cell.contentView.layer.shadowRadius = 0
        return setCellDetail(cell: cell, index: index)
    }
    // Permissions CollectionView set cell value
    func setCellDetail(cell: PermissionCell, index: Int) -> PermissionCell {
        
        let permission = self.allPermissions[index]
        //Set title lbl
        cell.lblTitle.text = permission.name
        
        //Set hexagon bage img
        var bageName = "ID_badge_"
        if permission.theme != nil {
            bageName += permission.theme!
            if let img = UIImage(named: bageName) {
                cell.imgBage.image = img
            }
        }
        //Download and set company logo
        cell.imgLogo.downloadedFrom(link: permission.avatarUrl)
        
        //Visible detail view
        permission.scopes?.forEach({ (value) in
            switch value {
            case Constants.PermissionScope.Emails:
                cell.viewEmail.isHidden = false
                break
            case Constants.PermissionScope.Phones:
                cell.viewPhone.isHidden = false
                break
            default:
                break
            }
        })
        return cell
    }
    
    //All permissions web service requeset, and collectionview reload
    //Redirect user to profile screen if permission is not defined
    func setAllPermissionsList(){
        UIUtils.showLoading()
        QrCodeWebServiceRequest().getUserAllPermissions { (allPermissionsList) in
            if allPermissionsList != nil{
                UIUtils.stopLoading()
                self.allPermissions = allPermissionsList!
                self.collectionContainer.reloadData()
            }else {
                UIUtils.stopLoading()
                PopupGenerator.createPopup(controller: self, type: .warning, popup: Popup(title: "allPermissionsNullTitle".localized, message: "allPermissionsNullMessage".localized, image: nil, buttonTitle: "allPermissionsNullButtonTitle".localized), btnClickCompletion: {
                    self.openProfilePage()
                })
            }
        }
    }
}
