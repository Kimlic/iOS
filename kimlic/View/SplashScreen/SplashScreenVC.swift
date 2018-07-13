//
//  SplashScreenVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 13.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import UIKit
import SwiftyUserDefaults

class SplashScreenVC: BaseVC {
    
    @IBOutlet weak var imgShield: UIImageView!
    @IBOutlet weak var viewImageContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //a new access token is taken if the access token is not taken
        if Defaults[.accessToken] == nil {
            TokenWebServiceRequest().clientCredentialsRequest(completion: { (tokenResponse) in
                if tokenResponse != nil {
                    Defaults[.accessToken] = tokenResponse?.accessToken
                }
            })
        }
        //Splash screen animation
        Animz.rotateY(layer: self.viewImageContainer.layer, angleFrom: 360, duration: Animz.time1) {
            UIView.animate(withDuration: Animz.time1 , animations: {
            },completion: {
                (finished: Bool) -> Void in
                
                let currentUser = CoreDataHelper.getUser()
                
                // kullanıcı token bilgisine göre düzenlenecek
                if currentUser != nil {
                    let _ = UIUtils.setUserProfileScreenAsRoot()
                }else {
                     let _ = UIUtils.setSignUpScreenAsRoot()
                }
            })
        }
    }
}
