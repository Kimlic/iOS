//
//  PhoneNumberVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 15.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.

import UIKit
import PhoneNumberKit
import SwiftyUserDefaults
import SwiftyJSON

class PhoneNumberVC: UIViewController {
    
    @IBOutlet weak var imgHexagonContent: UIImageView!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var country = [Country]()
    var selectedCode = "+90"
    var defaultSelectedIndex = 215 //  Set default Turkey phone code
    let phoneNumberKit = PhoneNumberKit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupPickerViews()
    }
    
    private func setupPickerViews(){
        // Load country data
        self.loadCountryData()
        
        // Set Data picker
        let countryPickerView = UIPickerView()
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        countryTextField.inputView = countryPickerView
        
        // Set default value
        self.pickerView(countryPickerView, didSelectRow: defaultSelectedIndex, inComponent: 0)
        countryPickerView.selectRow(defaultSelectedIndex, inComponent: 0, animated: false)
    }
    
    // Country code and name json file path "Resources > CountryCode.json"
    // PickerView set country code and name data
    func loadCountryData() {
        let path = Bundle.main.url(forResource: "CountryCode", withExtension: "json")
        let jsonData = try? Data(contentsOf: path!, options: Data.ReadingOptions.mappedIfSafe)
        let countryData = JSON(data: jsonData!)
        
        for (_, subJson) in countryData["countries"] {
            if let code = subJson["code"].string, let name = subJson["name"].string {
                country.append(Country(code: code, name: name))
            }
        }
    }
    
    @IBAction func phoneNumberTextFieldChanged(_ sender: Any) {
        let str = phoneNumberTextField.text
        guard (str?.range(of: selectedCode)) != nil else {
            phoneNumberTextField.text = selectedCode
            return
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        guard let phoneNumber = phoneNumberTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines), !phoneNumber.isEmpty else {
            return
        }
        
        do {
            let verificatePhone = try phoneNumberKit.parse(phoneNumber)
            UIUtils.navigateToVerification(self, phoneNumber: verificatePhone.numberString)
        }catch {
            PopupGenerator.createPopup(controller: self, type: .warning, popup: Popup(title: "phoneNotValidTitle".localized, message: "phoneNotValidMessage".localized, buttonTitle: "phoneNotValidButtonTitle".localized))
        }
        
    }
}

extension PhoneNumberVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.country.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.country[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.countryTextField.text = self.country[row].name
        self.selectedCode = self.country[row].code
        self.phoneNumberTextField.text = self.selectedCode
    }
    
    
}
