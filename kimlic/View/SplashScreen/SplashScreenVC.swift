//
//  SplashScreenVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 13.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import UIKit
import SwiftyUserDefaults

class SplashScreenVC: BaseVC {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgShield: UIImageView!
    @IBOutlet weak var viewImageContainer: UIView!
    
    // MARK: - Local Varibles
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let currentUser = CoreDataHelper.getUser()
    var navigateFunction: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rotateAnimation()
    }
    
    // MARK: - Functions
    private func rotateAnimation() {
        //Splash screen animation
        Animz.rotateY(layer: self.viewImageContainer.layer, angleFrom: 360, duration: Animz.time1) {
            
            if self.currentUser == nil {
                self.navigateFunction = UIUtils.setSignUpScreenAsRoot
            } else {
                self.appDelegate.createQuorum()
                self.navigateFunction = UIUtils.setUserProfileScreenAsRoot
            }
            
            UIView.animate(withDuration: Animz.time1 , animations: {}, completion: {
                (finished: Bool) -> Void in
                self.navigateFunction!()
            })
        }
    }
}
