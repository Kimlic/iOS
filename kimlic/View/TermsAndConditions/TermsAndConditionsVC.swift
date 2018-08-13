//
//  TermsAndConditionsVC.swift
//  kimlic
//
//  Created by izzet öztürk on 31.05.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class TermsAndConditionsVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var modifiedLabel: UILabel!
    @IBOutlet weak var termNoticeLabel: UILabel!
    @IBOutlet weak var termsDescLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    
    // MARK: -Local Varibles
    var nextPage: TermsNavigateTarget!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.alwaysBounceVertical = true
        self.scrollView.isDirectionalLockEnabled = true
        
        acceptButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.greenGradianteColors, frame: acceptButton.frame, type: .topBottom).color
    }
    
    // MARK: - IBActions
    
    @IBAction func acceptButtonPressed(_ sender: Any) {
        switch nextPage {
        case .phoneNumber:
            UIUtils.showLoading()
            createQuorum()
            UIUtils.navigateToPhoneNumber(self)
            UIUtils.stopLoading()
        case .accountRecovery:
            UIUtils.navigateToMnemonicImport(self)
        default:
            break
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Functions
    
    private func createQuorum() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.createQuorum()
    }
    
}
