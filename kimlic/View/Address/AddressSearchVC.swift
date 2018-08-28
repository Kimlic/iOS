//
//  AddressSearchVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 6.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import UIKit
import MapKit

class AddressSearchVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchTextField: CustomTextField!
    @IBOutlet weak var addressTableView: UITableView!
    @IBOutlet weak var emptyMessageView: UIView!
    
    // MARK: - Local Varibles
    let cellIdentifier = "AddressCell"
    var addressList = [MKMapItem]()
    var callback: ((MKMapItem)->())?
    let request = MKLocalSearchRequest()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set default display value
        setupView()
        
        // call reloadHandler func for empty table view message
        reloadHandler()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchTextField.becomeFirstResponder()
    }
    
    // MARK: - IBActions
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addressTextFieldChanged(_ sender: UITextField) {
        
        guard let searchWord = sender.text, !searchWord.isEmpty else {
            self.addressList = [MKMapItem]()
            reloadHandler()
            return
        }
        
        request.naturalLanguageQuery = sender.text
        let activeSearch = MKLocalSearch(request: request)
        
        activeSearch.start { (response, error) in
            if response == nil {
                // TODO: Error Popup
                print("ERROR")
            } else {
                self.addressList = response!.mapItems
                self.reloadHandler()
            }
        }
    }
    
    // MARK: - Functions
    
    private func setupView() {
        addressTableView.separatorColor = UIColor.seperatorBlue
        
        // for tableview clear seperator
        let footerView = UIView(frame: CGRect.zero)
        addressTableView.tableFooterView = footerView
        addressTableView.backgroundView = emptyMessageView
        
        // textfield clear button
        searchTextField.clearButtonMode = .whileEditing
    }
    
    // TableView reload data handler
    private func reloadHandler() {
        addressTableView.reloadData()
        if addressList.count > 0 {
            addressTableView.isScrollEnabled = true
            addressTableView.backgroundView?.isHidden = true
        } else {
            addressTableView.isScrollEnabled = false
            addressTableView.backgroundView?.isHidden = false
        }
    }

}

extension AddressSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont.MuliRegular18
        cell.textLabel?.textColor = UIColor.white
        tableView.separatorColor = UIColor.seperatorBlue
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        callback?(addressList[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        let address = addressList[indexPath.row]
        cell?.textLabel?.text = address.name
        cell?.imageView?.image = #imageLiteral(resourceName: "profile_blue_location_icon")
        return cell!
    }
}
