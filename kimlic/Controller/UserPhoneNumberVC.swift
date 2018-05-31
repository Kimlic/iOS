//
//  UserPhoneNumberVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 15.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import UIKit
import PhoneNumberKit
import SwiftyUserDefaults
import SwiftyJSON

class UserPhoneNumberVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
    
    @IBOutlet weak var txtMobilePhone: UITextField!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var imgHexagon: UIImageView!
    @IBOutlet weak var imgHexagonContent: UIImageView!
    
    var country = [String]()
    var countryCode = [String]()
    var selectedCode = ""
    var defaultSelected = 85 // Germany phone code set default
    let phoneNumberKit = PhoneNumberKit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pickerview set country data
        setCountryData()
        
        countryPicker.dataSource = self
        countryPicker.delegate = self
        
        self.pickerView(countryPicker, didSelectRow: defaultSelected, inComponent: 0)
        countryPicker.selectRow(defaultSelected, inComponent: 0, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Animz.fadeIn(image: imgHexagon, duration: Animz.time06)
        Animz.fadeIn(image: imgHexagonContent, duration: Animz.time06)
    }
    // Country code and name json file path "Resources > country_code.json"
    // PickerView set country code and name data
    func setCountryData() {
        let path = Bundle.main.url(forResource: "country_code", withExtension: "json")
        let jsonData = try? Data(contentsOf: path!, options: Data.ReadingOptions.mappedIfSafe)
        let countryData = JSON(data: jsonData!)
        
        for (_, subJson) in countryData["countries"] {
            if let code = subJson["code"].string {
                countryCode.append(code)
            }
            if let value = subJson["name"].string {
                country.append(value)
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return country[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return country.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtMobilePhone.text = countryCode[row]
        lblCountryName.text = country[row]
        selectedCode = countryCode[row]
    }
    
    @IBAction func txtPhoneNumberChanged(_ sender: Any) {
        let str = txtMobilePhone.text
        guard (str?.range(of: selectedCode)) != nil else {
            txtMobilePhone.text = selectedCode
            return
        }
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSavePressed(_ sender: Any) {
        
        let phoneNumber = txtMobilePhone?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !(phoneNumber?.isEmpty)! else {
            return
        }
        do {
            UIUtils.showLoading()
            let verificatePhone = try phoneNumberKit.parse(phoneNumber!)
            PhoneWebServiceRequest().createPhone(phoneNumber: verificatePhone.adjustedNationalNumber(), countryCode: verificatePhone.countryCode, completion: { (phoneResponse) in
                if phoneResponse != nil {
                    UIUtils.stopLoading()
                    UIUtils.navigateToUserPhoneValidate(vc: self, phoneNumber: verificatePhone)
                }else {
                    UIUtils.stopLoading()
                    PopupGenerator.createPopup(controller: self, type: .error, popup: Popup())
                }
            })
            
        }catch {
            UIUtils.stopLoading()
            PopupGenerator.createPopup(controller: self, type: .warning, popup: Popup(title: "phoneNotValidTitle".localized, message: "phoneNotValidMessage".localized, buttonTitle: "phoneNotValidButtonTitle".localized))
        }
        
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        countryView.isHidden = true
    }
    
    @IBAction func selectedCountryPressed(_ sender: Any) {
        txtMobilePhone.endEditing(true)
        countryView.isHidden = false
    }    
}
