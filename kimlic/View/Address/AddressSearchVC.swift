//
//  AddressSearchVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 6.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import UIKit
import GoogleMapsBase
import GooglePlaces

class AddressSearchVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchTextField: CustomTextField!
    @IBOutlet weak var addressTableView: UITableView!
    @IBOutlet weak var emptyMessageView: UIView!
    
    // MARK: - Local Varibles
    let cellIdentifier = "AddressCell"
    let googlePlaceAPIKey = "AIzaSyAhJoblJTjmCVjLKVmBAf2APWEhiqkbJWc"
    var addressList = [GMSAutocompletePrediction]()
    lazy var filter: GMSAutocompleteFilter = {
       let filter = GMSAutocompleteFilter()
        filter.type = .address
        return filter
    }()
    var callback: ((GMSAutocompletePrediction)->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSPlacesClient.provideAPIKey(googlePlaceAPIKey)

        // Set default display value
        setupView()
        
        // call reloadHandler func for empty table view message
        reloadHandler()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchTextField.becomeFirstResponder()
    }
    
    @IBAction func addressTextFieldChanged(_ sender: UITextField) {
        
        guard let searchWord = sender.text, !searchWord.isEmpty else {
            self.addressList = [GMSAutocompletePrediction]()
            reloadHandler()
            return
        }
        
        GMSPlacesClient.shared().autocompleteQuery(searchWord, bounds: nil, filter: filter) { (responseList, error) in
            if error == nil && responseList != nil {
                self.addressList = responseList!
                self.reloadHandler()
            }
        }
    }
    
    private func setupView() {
        addressTableView.separatorColor = UIColor.seperatorBlue
        
        // for tableview clear seperator
        let footerView = UIView(frame: CGRect.zero)
        addressTableView.tableFooterView = footerView
        
        // textfield clear button
        searchTextField.clearButtonMode = .whileEditing
    }
    
    // TableView reload data handler
    private func reloadHandler() {
        addressTableView.reloadData()
//        if addressList.count > 0 {
//            addressTableView.backgroundView = nil
//        } else {
//            addressTableView.backgroundView = emptyMessageView
//        }
    }

}

extension AddressSearchVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
        cell?.textLabel?.attributedText = addressList[indexPath.row].attributedFullText
        cell?.imageView?.image = #imageLiteral(resourceName: "profile_blue_location_icon")
        return cell!
    }
}
