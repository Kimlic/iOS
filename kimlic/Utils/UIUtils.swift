//
//  UIUtils.swift
//  kimlic
//
//  Created by İzzet Öztürk on 20.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import UIKit
import SwiftyUserDefaults
import LocalAuthentication
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
    
    static func presentVerificationCodeVC(vc: UIViewController, pageType: VerificationCodePageType, qrCode: String?, completion: (() -> Swift.Void)? = nil) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let verificationVC = storyboard.instantiateViewController(withIdentifier: VerificationCodeVC.className) as! VerificationCodeVC
        verificationVC.pageType = pageType
        verificationVC.baseController = vc
        verificationVC.qrCode = qrCode
        verificationVC.modalPresentationStyle = .overCurrentContext
        vc.present(verificationVC, animated: true, completion: {
            completion?()
        })
    }
    
    static func navigateToTutorial(vc: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tarVC = storyboard.instantiateViewController(withIdentifier: TutorialsVC.className) as! TutorialsVC
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
    
    static func navigateToUserPhoneNumber(vc: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tarVC = storyboard.instantiateViewController(withIdentifier: UserPhoneNumberVC.className) as! UserPhoneNumberVC
        vc.navigationController?.pushViewController(tarVC, animated: true)
    }
    
    static func navigateToUserPhoneValidate(vc: UIViewController, phoneNumber: PhoneNumber!){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tarVC = storyboard.instantiateViewController(withIdentifier: UserPhoneNumberValidateVC.className) as! UserPhoneNumberValidateVC
        tarVC.phoneNumber = phoneNumber
        vc.navigationController?.pushViewController(tarVC, animated: true)
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
    //Touch ID Confirm
    //This feature is used in tutorial and permission detail screens
    //targetcontroller: UserBasicProfile or UserProfile
    static func confirmTouchID(controller: UIViewController, targetController: TouchIDNavigateTarget, qrCode: String?){
        let myContext = LAContext()
        var authError: NSError?
        
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "touchIDConfirmMessage".localized) { success, evaluateError in
                    if success {
                        DispatchQueue.main.async(){
                            switch targetController {
                            case .UserBasicProfileVC: //If touch id validation is successful user redirect UserBasicProfile screen
                                Defaults[.verificationCodeEnable] = nil
                                Defaults[.verificationCode] = nil
                                self.navigateToUserBasicProfile(vc: controller)
                                break
                            case .UserProfileVC:
                                self.authenticationWebServiceRequest(controller: controller, qrCode: qrCode)
                                break
                            }
                        }
                    } else {
                        if authError != nil {
                            PopupGenerator.createPopup(controller: controller, type: .error, popup: Popup(title: "Error", message: authError?.localizedDescription, buttonTitle: "OK"))
                        }
                    }
                }
            } else {
                PopupGenerator.createPopup(controller: controller, type: .error, popup: Popup(title: "Error", message: authError?.localizedDescription, buttonTitle: "OK"))
            }
        } else {
            PopupGenerator.createPopup(controller: controller, type: .error, popup: Popup(title: "notSupportedTitle".localized, message: "notSupportedMessage".localized, buttonTitle: "notSupportedButtonTitle".localized))
        }
    }
    
    static func authenticationWebServiceRequest(controller: UIViewController, qrCode: String?) {
        
        if let appId = qrCode?.getAppIdFromQrCode(), let token = qrCode?.getToken() {
            self.showLoading()
            QrCodeWebServiceRequest().authenticationRequest(appId: appId, token: token, completion: { (success) in
                // If the read qr code is verified by the web service, the user is directed to the UserProfile screen and the relevant popup is displayed
                if success != nil {
                    self.showLoading()
                    let rootController = controller.navigationController?.viewControllers.first as! UserProfileVC
                    controller.navigationController?.popRootViewControllerWithHandler(completion: {
                        Animz.newScreenAddedAnimation(controller: rootController)
                    })
                }else {
                    self.stopLoading()
                    PopupGenerator.createPopup(controller: controller, type: .error, popup: Popup())
                }
            })
        }
        
    }
    
    // Loading 
    static func showLoading(){
        let activityData = ActivityData(type: .ballClipRotate, color: Constants.Colors.appBlue)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    static func stopLoading(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
