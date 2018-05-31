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
    @IBOutlet weak var labelLogo: UILabel!
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
        Animz.rotateY(layer: self.viewImageContainer.layer, angleFrom: 180, duration: Animz.time06) {
            UIView.animate(withDuration: Animz.time08 , animations: {
                self.labelLogo.alpha = 1.0
            },completion: {
                (finished: Bool) -> Void in
                if Defaults[.userToken] == nil {
                    let _ = UIUtils.setSignUpScreenAsRoot()
                }else {
                    let _ = UIUtils.setUserProfileScreenAsRoot()
                }
            })
        }
    }
}
