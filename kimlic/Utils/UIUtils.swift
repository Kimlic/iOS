//
//  UIUtils.swift
//  kimlic
//
//  Created by İzzet Öztürk on 20.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.

import Foundation
import UIKit
import SwiftyUserDefaults
import NVActivityIndicatorView
import GooglePlaces

public class UIUtils {
    
    static func setSignUpScreenAsRoot(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let window :UIWindow = appDelegate.window!
        let storyboard = AppStoryboard.SignUp.instance
        let homeVC = storyboard.instantiateViewController(withIdentifier: SignUpVC.className) as! SignUpVC
        let navVc = UINavigationController(rootViewController: homeVC)
        navVc.isNavigationBarHidden = true
        UIView.transition(with: appDelegate.window!, duration: 0.3, options: .transitionFlipFromRight, animations: {
            window.rootViewController = navVc
        }, completion: { completed in
            // maybe do something here
        })
    }
    
    static func setTutorialScreenAsRoot() -> TutorialsVC {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let window :UIWindow = appDelegate.window!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: TutorialsVC.className) as! TutorialsVC
        let navVc = UINavigationController(rootViewController: homeVC)
        navVc.isNavigationBarHidden = true
        UIView.transition(with: appDelegate.window!, duration: 0.3, options: .transitionFlipFromRight, animations: {
            window.rootViewController = navVc
        }, completion: { completed in
            // maybe do something here
        })
        return homeVC
    }
    
    static func setUserProfileScreenAsRoot(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let window: UIWindow = appDelegate.window!
        let storyboard = AppStoryboard.Profile.instance
        let homeVC = storyboard.instantiateViewController(withIdentifier: ProfileVC.className) as! ProfileVC
        let navVc = UINavigationController(rootViewController: homeVC)
        navVc.isNavigationBarHidden = true
        UIView.transition(with: appDelegate.window!, duration: 0.3, options: .transitionFlipFromRight, animations: {
            window.rootViewController = navVc
        }, completion: { completed in
            // maybe do something here
        })
    }
    
    static func navigateToProfile(_ vc: UIViewController){
        let storyboard = AppStoryboard.Profile.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: ProfileVC.className) as! ProfileVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToSettings(_ vc: UIViewController){
        let storyboard = AppStoryboard.Settings.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: SettingsVC.className) as! SettingsVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToTutorial(_ vc: UIViewController){
        let storyboard = AppStoryboard.Tutorial.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: TutorialsVC.className) as! TutorialsVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToTouchID(_ vc: UIViewController, successCompletion: ((TouchIDVC)->Void)? = nil ) {
        let storyboard = AppStoryboard.TouchID.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: TouchIDVC.className) as! TouchIDVC
        tarVC.succussCompletion = successCompletion
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToTerms(_ vc: UIViewController, nextPage: TermsNavigateTarget){        
        let storyboard = AppStoryboard.TermsAndConditions.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: TermsAndConditionsVC.className) as! TermsAndConditionsVC
        tarVC.nextPage = nextPage
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToUserInfo(_ vc: UIViewController){
        let storyboard = AppStoryboard.UserInfo.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: UserInfoVC.className) as! UserInfoVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToEmail(_ vc: UIViewController){
        let storyboard = AppStoryboard.UserEmail.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: UserEmailVC.className) as! UserEmailVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToPhoneNumber(_ vc: UIViewController){
        let storyboard = AppStoryboard.PhoneNumber.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: PhoneNumberVC.className) as! PhoneNumberVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToVerification(_ vc: UIViewController, phoneNumber: String? = nil, email: String? = nil){
        let storyboard = AppStoryboard.Verification.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: VerificationVC.className) as! VerificationVC
        tarVC.phoneNumber = phoneNumber
        tarVC.email = email
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToVerifyIDDetail(_ vc: UIViewController, documentType: DocumentType, frontImage: UIImage?, backImage: UIImage?){
        let storyboard = AppStoryboard.VerifyIDDetail.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: VerifyIDDetailVC.className) as! VerifyIDDetailVC
        tarVC.documentType = documentType
        tarVC.frontImage = frontImage
        tarVC.backImage = backImage
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToVerifyID(_ vc: UIViewController){
        let storyboard = AppStoryboard.VerifyID.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: VerifyIDVC.className) as! VerifyIDVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToProfileCamera(_ vc: UIViewController){
        let storyboard = AppStoryboard.ProfileCamera.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: ProfileCameraVC.className) as! ProfileCameraVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToQRCode(_ vc: UIViewController){
        let storyboard = AppStoryboard.QRCode.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: QRCodeVC.className) as! QRCodeVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToAddress(_ vc: UIViewController){
        let storyboard = AppStoryboard.Address.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: AddressVC.className) as! AddressVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToAddressSearch(_ vc: UIViewController, callback: ((GMSAutocompletePrediction) -> ())? = nil){
        let storyboard = AppStoryboard.AddressSearch.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: AddressSearchVC.className) as! AddressSearchVC
        tarVC.callback = callback
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    // Message = Constants > StaticMessage
    static func navigateToMessage(_ vc: UIViewController, messageType: MessageType, message: Message? = nil){
        let storyboard = AppStoryboard.Message.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: MessageVC.className) as! MessageVC
        switch messageType {
        case .addressSuccessfull:
            tarVC.message.icon = message?.icon ?? Constants.StaticMessage.addressSuccessfull.icon
            tarVC.message.title = message?.title ?? Constants.StaticMessage.addressSuccessfull.title
            tarVC.message.desc = message?.desc ?? Constants.StaticMessage.addressSuccessfull.desc
        case .passphraseSuccessfull:
            tarVC.message.icon = message?.icon ?? Constants.StaticMessage.passphraseSuccessfull.icon
            tarVC.message.title = message?.title ?? Constants.StaticMessage.passphraseSuccessfull.title
            tarVC.message.desc = message?.desc ?? Constants.StaticMessage.passphraseSuccessfull.desc
        case .passMatchSuccessfull:
            tarVC.message.icon = message?.icon ?? Constants.StaticMessage.passMatchSuccessfull.icon
            tarVC.message.title = message?.title ?? Constants.StaticMessage.passMatchSuccessfull.title
            tarVC.message.desc = message?.desc ?? Constants.StaticMessage.passMatchSuccessfull.desc
        case .passcodeSuccessfull:
            tarVC.message.icon = message?.icon ?? Constants.StaticMessage.pascodeSuccessfull.icon
            tarVC.message.title = message?.title ?? Constants.StaticMessage.pascodeSuccessfull.title
            tarVC.message.desc = message?.desc ?? Constants.StaticMessage.pascodeSuccessfull.desc
        case .touchIDSuccessfull:
            tarVC.message.icon = message?.icon ?? Constants.StaticMessage.touchIDSuccessfull.icon
            tarVC.message.title = message?.title ?? Constants.StaticMessage.touchIDSuccessfull.title
            tarVC.message.desc = message?.desc ?? Constants.StaticMessage.touchIDSuccessfull.desc
        case .verifyIDSuccessfull:
            tarVC.message.icon = message?.icon ?? Constants.StaticMessage.verifyIDSuccessfull.icon
            tarVC.message.title = message?.title ?? Constants.StaticMessage.verifyIDSuccessfull.title
            tarVC.message.desc = message?.desc ?? Constants.StaticMessage.verifyIDSuccessfull.desc
        case .phoneNumberSuccessfull:
            tarVC.message.icon = message?.icon ?? Constants.StaticMessage.phoneNumberSuccessfull.icon
            tarVC.message.title = message?.title ?? Constants.StaticMessage.phoneNumberSuccessfull.title
            tarVC.message.desc = message?.desc ?? Constants.StaticMessage.phoneNumberSuccessfull.desc
        case .emailSuccessfull:
            tarVC.message.icon = message?.icon ?? Constants.StaticMessage.emailSuccessfull.icon
            tarVC.message.title = message?.title ?? Constants.StaticMessage.emailSuccessfull.title
            tarVC.message.desc = message?.desc ?? Constants.StaticMessage.emailSuccessfull.desc
        case .accountLinkSuccessfull:
            tarVC.message.icon = message?.icon ?? Constants.StaticMessage.accountLinkSuccessfull.icon
            tarVC.message.title = message?.title ?? Constants.StaticMessage.accountLinkSuccessfull.title
            tarVC.message.desc = message?.desc ?? Constants.StaticMessage.accountLinkSuccessfull.desc
        case .fullNameSuccessfull:
            tarVC.message.icon = message?.icon ?? Constants.StaticMessage.fullNameSuccessfull.icon
            tarVC.message.title = message?.title ?? Constants.StaticMessage.fullNameSuccessfull.title
            tarVC.message.desc = message?.desc ?? Constants.StaticMessage.fullNameSuccessfull.desc
        }
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToMnemonicImport(_ vc: UIViewController){
        let storyboard = AppStoryboard.MnemonicImport.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: MnemonicImportVC.className) as! MnemonicImportVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToMnemonicCreate(_ vc: UIViewController){
        let storyboard = AppStoryboard.MnemonicCreate.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: MnemonicCreateVC.className) as! MnemonicCreateVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToMnemonicVerification(_ vc: UIViewController){
        let storyboard = AppStoryboard.MnemonicVerification.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: MnemonicVerificationVC.className) as! MnemonicVerificationVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToUserBasicProfile(vc: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tarVC = storyboard.instantiateViewController(withIdentifier: UserBasicProfileInfoVC.className) as! UserBasicProfileInfoVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToUserProfile(vc: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tarVC = storyboard.instantiateViewController(withIdentifier: UserProfileVC.className) as! UserProfileVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToUserProfileWithHandler(vc: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tarVC = storyboard.instantiateViewController(withIdentifier: UserProfileVC.className) as! UserProfileVC
        vc.navigationController?.pushViewControllerWithHandler(tarVC: tarVC, completion: {
            let _ = self.setUserProfileScreenAsRoot()
        })
    }
    
    static func navigateToAllPermissionsFooter(vc: UIViewController, completion: @escaping() -> ()){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tarVC = storyboard.instantiateViewController(withIdentifier: AllPermissionsVC.className) as! AllPermissionsVC
        
        let transition: CATransition = CATransition()
        CATransaction.begin()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = Animz.time04
        transition.timingFunction = timeFunc
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromLeft
        vc.navigationController!.view.layer.add(transition, forKey: kCATransition)
        vc.navigationController!.pushViewController(tarVC, animated: false)
        // Callback function
        CATransaction.setCompletionBlock {
            completion()
        }
        CATransaction.commit()
    }
    
    static func navigateToUserProfileFooter(vc: UIViewController){
        let transition: CATransition = CATransition()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = Animz.time04
        transition.timingFunction = timeFunc
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromRight
        vc.navigationController!.view.layer.add(transition, forKey: kCATransition)
        vc.navigationController!.popViewController(animated: false)
    }
    
    static func navigateToPermissionDetail(vc: UIViewController, permission: PermissionDetailResponse, qrCode: String!){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tarVC = storyboard.instantiateViewController(withIdentifier: PermissionDetailVC.className) as! PermissionDetailVC
        tarVC.permission = permission
        tarVC.qrCode = qrCode
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToScanCode(vc: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tarVC = storyboard.instantiateViewController(withIdentifier: ScanCodeVC.className) as! ScanCodeVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    // Loading 
    static func showLoading(){
        let activityData = ActivityData(type: .ballClipRotate, color: Constants.Colors.appBlue)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    static func stopLoading(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    // completion -> Page popover
    static func showPasscodeVC(vc: UIViewController, pageType: PasscodePageType, tmpCode: String? = nil, completion: (() -> Swift.Void)? = nil, cancelCompletion: (() -> Void)? = nil) {
        let storyboard = AppStoryboard.Passcode.instance
        let passVC = storyboard.instantiateViewController(withIdentifier: PasscodeVC.className) as! PasscodeVC
        passVC.modalPresentationStyle = .overCurrentContext
        passVC.pageType = pageType
        passVC.tmpCode = tmpCode
        passVC.rootVC = vc
        passVC.cancelCompletion = cancelCompletion
        vc.present(passVC, animated: true, completion: {
            completion?()
        })
    }
}
