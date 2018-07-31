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
import web3swift
import Alamofire

class PhoneNumberVC: UIViewController {
    // MARK: - IBOutles
    @IBOutlet weak var imgHexagonContent: UIImageView!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Local Varibles
    var country = [Country]()
    var selectedCode = "+90"
    var defaultSelectedIndex = 215 //  Set default Turkey phone code
    let phoneNumberKit = PhoneNumberKit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default view
        setupView()
        
        // Set default country data
        self.setupPickerViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        phoneNumberTextField.becomeFirstResponder()
    }
    
    // MARK: - IBActions
    
    @IBAction func phoneNumberTextFieldChanged(_ sender: Any) {
        let str = phoneNumberTextField.text
        guard (str?.range(of: selectedCode)) != nil else {
            phoneNumberTextField.text = selectedCode
            return
        }
        phoneNumberTextField.text = PartialFormatter().formatPartial(str!)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let phoneNumber = phoneNumberTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !phoneNumber.isEmpty else {
                return
        }
        do {
            let verificatePhone = try phoneNumberKit.parse(phoneNumber)
            serverRequest(verificatePhone.numberString.replacingOccurrences(of: " ", with: ""))
        } catch {
            showPhoneError("errorMessage".localized)
        }
    }
    
    // MARK: - Functions
    
    private func setupView() {
        nextButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.blueGradianteColors, frame: nextButton.frame, type: .topBottom).color
    }
    
    private func setupPickerViews(){
        // Load country data
        self.loadCountryData()
        
        // Set Data picker
        let countryPickerView = UIPickerView()
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        countryTextField.inputView = countryPickerView
        
        countryPickerView.backgroundColor = countryPickerView.keyboardToolbar.backgroundColor
        
        // Set default value
        self.pickerView(countryPickerView, didSelectRow: defaultSelectedIndex, inComponent: 0)
        countryPickerView.selectRow(defaultSelectedIndex, inComponent: 0, animated: false)
    }
    
    // Country code and name json file path "Resources > CountryCode.json"
    // PickerView set country code and name data
    private func loadCountryData() {
        let path = Bundle.main.url(forResource: "CountryCode", withExtension: "json")
        let jsonData = try? Data(contentsOf: path!, options: Data.ReadingOptions.mappedIfSafe)
        let countryData = JSON(data: jsonData!)
        
        for (_, subJson) in countryData["countries"] {
            if let code = subJson["code"].string, let name = subJson["name"].string {
                country.append(Country(code: code, name: name))
            }
        }
    }
    
    private func serverRequest(_ phone: String) {
        UIUtils.showLoading()
        CustomWebServiceRequest.createPhone(phone: phone, success: {
            UIUtils.stopLoading()
            UIUtils.navigateToVerification(self, phoneNumber: phone)
        }) { (error) in
            UIUtils.stopLoading()
            self.showPhoneError(error)
        }
    }
    
    private func showPhoneError(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            let popup = Popup(title: "Warning", message: message, image: #imageLiteral(resourceName: "phone_with_circle"), buttonTitle: nil)
            PopupGenerator.baseCancelAlertPopup(controller: strongSelf, popup: popup)
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
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: self.country[row].name, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
    
}
