//
//  MessageVC.swift
//  kimlic
//
//  Created by izzet öztürk on 4.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class MessageVC: UIViewController {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    var messageType: MessageType = .successPhoneNumber
    var message: Message?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set default value
        setupView()
        
        let _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(MessageVC.redirectHome), userInfo: nil, repeats: false)
    }
    
    @objc func redirectHome() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupView() {
        switch messageType {
        case .none:
            iconImageView.image = message?.icon
            titleLabel.text = message?.title
            descLabel.text = message?.desc
        case .successPhoneNumber:
            iconImageView.image = #imageLiteral(resourceName: "Success_popup_illustration")
            titleLabel.text = Constants.Message.congratulation
            descLabel.text = Constants.Message.successPhoneNumber
        case .successMnenomic:
            iconImageView.image = #imageLiteral(resourceName: "Success_popup_illustration")
            titleLabel.text = Constants.Message.congratulation
            descLabel.text = Constants.Message.successMnemonic
        case .successPasscode:
            iconImageView.image = #imageLiteral(resourceName: "tutorial_3_illustration")
            titleLabel.text = Constants.Message.idSecured
            descLabel.text = Constants.Message.successPasscode
        case .successTouchID:
            iconImageView.image = #imageLiteral(resourceName: "touch_ID_popup_illustration")
            titleLabel.text = Constants.Message.congratulation
            descLabel.text = Constants.Message.successTouchID
        
        }
    }
}
