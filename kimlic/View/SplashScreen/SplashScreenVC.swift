//
//  SplashScreenVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 13.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.

import UIKit

class SplashScreenVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgShield: UIImageView!
    @IBOutlet weak var viewImageContainer: UIView!
    
    // MARK: - Local Varibles
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var currentUser: KimlicUser?
    var navigateFunction: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get current user in core data
        currentUser = CoreDataHelper.getUser()
        
        rotateAnimation()
    }
    
    // MARK: - Functions
    private func rotateAnimation() {
        //Splash screen animation
        Animz.rotateY(layer: self.viewImageContainer.layer, angleFrom: 360, duration: Animz.time1) {
            self.navigateFunction = UIUtils.setUserProfileScreenAsRoot
//            if self.isOldUserCheck() {
//                self.appDelegate.createQuorum()
//                self.navigateFunction = UIUtils.setUserProfileScreenAsRoot
//            } else {
//                self.navigateFunction = UIUtils.setSignUpScreenAsRoot
//            }
            
            UIView.animate(withDuration: Animz.time1 , animations: {}, completion: {
                (finished: Bool) -> Void in
                self.navigateFunction!()
            })
        }
    }
    
    private func isOldUserCheck() -> Bool {
        if currentUser == nil || currentUser?.phone == nil || currentUser?.email == nil {
            return false
        }
        return true
    }
}
