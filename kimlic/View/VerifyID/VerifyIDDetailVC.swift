//
//  VerifyIDDetailVC.swift
//  kimlic
//
//  Created by izzet öztürk on 30.07.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import UIKit

class VerifyIDDetailVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var cardFrontImage: UIImageView!
    @IBOutlet weak var cardBackImage: UIImageView!
    
    var user: KimlicUser?

    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get user data
        user = CoreDataHelper.getUser()
        
        // Set data
        setupData()
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Functions
    
    private func setupData() {
        
        if let frontData = user?.cardFrontPhoto, let frontPhoto = UIImage(data: frontData) {
            cardFrontImage.image = frontPhoto
        }
        
        if let backData = user?.cardBackPhoto, let backPhoto = UIImage(data: backData) {
            cardBackImage.image = backPhoto
        }
    }
    
}
