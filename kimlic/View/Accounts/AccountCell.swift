//
//  AccountCell.swift
//  kimlic
//
//  Created by İzzet Öztürk on 16.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Functions
    
    func setData(logo: UIImage, siteName: String, date: String) {
        self.logo.image = logo
        self.siteNameLabel.text = siteName
        self.dateLabel.text = date
    }
    
}
