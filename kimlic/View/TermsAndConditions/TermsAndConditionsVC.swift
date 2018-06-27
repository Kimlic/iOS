//
//  TermsAndConditionsVC.swift
//  kimlic
//
//  Created by izzet öztürk on 31.05.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class TermsAndConditionsVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var modifiedLabel: UILabel!
    @IBOutlet weak var termNoticeLabel: UILabel!
    @IBOutlet weak var termsDescLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    
    var nextPage: TermsNavigateTarget!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.alwaysBounceVertical = true
        self.scrollView.isDirectionalLockEnabled = true
        
        acceptButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.greenGradianteColors, frame: acceptButton.frame, type: .topBottom).color
        
//        if nextPage == TermsNavigateTarget.none {
//            acceptButton.isHidden = true
//        }else {
//            acceptButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.greenGradianteColors, frame: acceptButton.frame, type: .topBottom).color
//        }
    }
    
    @IBAction func acceptButtonPressed(_ sender: Any) {
        switch nextPage {
        case .phoneNumber:
            UIUtils.navigateToPhoneNumber(self)
        case .accountRecovery:
            UIUtils.navigateToMnemonicImport(self)
        default:
            break
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
