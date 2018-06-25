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
    
    var message: Message?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set default value
        setupView()
        
        let _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(MessageVC.redirectHome), userInfo: nil, repeats: false)
    }
    
    @objc func redirectHome() {
        UIUtils.navigateToProfile(self)
    }
    
    private func setupView() {
        iconImageView.image = message?.icon
        titleLabel.text = message?.title
        descLabel.text = message?.desc
    }
}
