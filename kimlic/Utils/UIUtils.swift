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
import PhoneNumberKit


public class UIUtils {
    
    static func setSignUpScreenAsRoot() -> SignUpVC {
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
        return homeVC
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
    
    static func setUserProfileScreenAsRoot() -> UserProfileVC{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let window :UIWindow = appDelegate.window!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: UserProfileVC.className) as! UserProfileVC
        let navVc = UINavigationController(rootViewController: homeVC)
        navVc.isNavigationBarHidden = true
        
        
        UIView.transition(with: appDelegate.window!, duration: 0.3, options: .transitionFlipFromRight, animations: {
            window.rootViewController = navVc
        }, completion: { completed in
            // maybe do something here
        })
        
        return homeVC
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
    
    static func navigateToTouchID(_ vc: UIViewController) {
        let storyboard = AppStoryboard.TouchID.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: TouchIDVC.className) as! TouchIDVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToTerms(_ vc: UIViewController){
        let storyboard = AppStoryboard.TermsAndConditions.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: TermsAndConditionsVC.className) as! TermsAndConditionsVC
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
    
    static func navigateToPhoneVerification(_ vc: UIViewController, phoneNumber: PhoneNumber){
        let storyboard = AppStoryboard.PhoneVerification.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: PhoneVerificationVC.className) as! PhoneVerificationVC
        tarVC.phoneNumber = phoneNumber
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToMessage(_ vc: UIViewController, messageType: MessageType, message: Message? = nil){
        let storyboard = AppStoryboard.Message.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: MessageVC.className) as! MessageVC
        tarVC.messageType = messageType
        tarVC.message = message
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
    
    static func navigateToConfirmPassphrase(_ vc: UIViewController){
        let storyboard = AppStoryboard.ConfirmPassphrase.instance
        let tarVC = storyboard.instantiateViewController(withIdentifier: ConfirmPassphraseVC.className) as! ConfirmPassphraseVC
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
    
    static func showPasscodeVC(vc: UIViewController, pageType: PasscodePageType, tmpCode: String? = nil, completion: (() -> Swift.Void)? = nil) {
        let storyboard = AppStoryboard.Passcode.instance
        let passVC = storyboard.instantiateViewController(withIdentifier: PasscodeVC.className) as! PasscodeVC
        passVC.modalPresentationStyle = .overCurrentContext
        passVC.pageType = pageType
        passVC.tmpCode = tmpCode
        passVC.rootVC = vc
        vc.present(passVC, animated: true, completion: {
            completion?()
        })
    }
}
