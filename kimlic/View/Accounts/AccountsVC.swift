//
//  AccountsVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 15.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import UIKit

class AccountsVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var accountsTableView: UITableView!
    @IBOutlet weak var emptyMessageView: UIView!

    // MARK: - Local Varibles
    var accountList: [(name: String, date: String)] = [(name: "Amazon", date: "23 June 2018"),
                                                       (name: "Dropbox", date: "23 June 2018"),
                                                       (name: "Ebay", date: "4 May 2018"),
                                                       (name: "ICO Bench", date: "13 Apr 2018"),
                                                       (name: "Streamr ICO", date: "01 Sep 2018"),
                                                       (name: "Ali Baba", date: "23 June 2017"),
                                                       (name: "Bangood", date: "23 June 2017"),
                                                       (name: "Sahibinden", date: "23 June 2016"),
                                                       (name: "Paltimoz", date: "23 June 2016"),]
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set default view
        setupView()
        
        // call reloadHandler func for empty table view message
        reloadHandler()
    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    
    private func setupView() {
        // for tableview clear seperator
        accountsTableView.backgroundView = emptyMessageView
    }
    
    // TableView reload data handler
    private func reloadHandler() {
        accountsTableView.reloadData()
        if accountList.count > 0 {
            accountsTableView.isScrollEnabled = true
            accountsTableView.backgroundView?.isHidden = true
        } else {
            accountsTableView.isScrollEnabled = false
            accountsTableView.backgroundView?.isHidden = false
        }
    }

}

extension AccountsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AccountCell.className) as? AccountCell {
            cell.setData(logo: #imageLiteral(resourceName: "kimlic_logo_with_text"), siteName: accountList[indexPath.row].name, date: accountList[indexPath.row].date)
            return cell
        }
        return AccountCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30// space b/w cells
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.clear
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        return footer
    }
    
    
}
