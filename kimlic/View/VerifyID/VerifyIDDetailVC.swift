//
//  VerifyIDDetailVC.swift
//  kimlic
//
//  Created by izzet öztürk on 30.07.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import UIKit
import SwiftyJSON

class VerifyIDDetailVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var documentNumber: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var expiryDateTextField: UITextField!
    @IBOutlet weak var cardFrontImage: UIImageView!
    @IBOutlet weak var cardBackImage: UIImageView!
    @IBOutlet weak var newIDButton: CustomButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Local Varibles
    
    var verifyIDModel: VerifyIDModel!
    var user: KimlicUser?
    var country = [Country]()
    var selectedCode = "tr"
    var selectedDate: Date = Date()
    var defaultSelectedIndex = 222 //  Set default Turkey phone code

    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get user data
        user = CoreDataHelper.getUser()
        
        setupView()
        
        // Set data
        setupData()
        
        setupPickerViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        documentNumber.becomeFirstResponder()
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        serverRequest()
    }
    
    // MARK: - Functions
    
    private func serverRequest() {
        CustomWebServiceRequest.saveVerificationDocument()
    }
    
    private func setupView() {
        newIDButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.blueGradianteColors, frame: newIDButton.frame, type: .topBottom).color
    }
    
    private func setupData() {
        titleLabel.text = verifyIDModel.documentType?.description
        cardFrontImage.image = verifyIDModel.documentFrontImage
        cardBackImage.image = verifyIDModel.documentBackImage
        
        expiryDateTextField.text = dateFortmatted(date: Date())
    }
    
    private func setupPickerViews(){
        // Load country data
        loadCountryData()
        
        // Set Data picker
        let countryPickerView = UIPickerView()
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        countryTextField.inputView = countryPickerView
        
        countryPickerView.backgroundColor = countryPickerView.keyboardToolbar.backgroundColor
        
        // Set default value
        pickerView(countryPickerView, didSelectRow: defaultSelectedIndex, inComponent: 0)
        countryPickerView.selectRow(defaultSelectedIndex, inComponent: 0, animated: false)
        
        // Set Date Picker
        let datePickerView = DarkDatePicker()
        datePickerView.datePickerMode = .date
        expiryDateTextField.inputView = datePickerView
        
        datePickerView.backgroundColor = datePickerView.keyboardToolbar.backgroundColor
        datePickerView.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
    }
    
    // Country code and name json file path "Resources > CountryCode.json"
    // PickerView set country code and name data
    private func loadCountryData() {
        let path = Bundle.main.url(forResource: "CountryCode", withExtension: "json")
        let jsonData = try? Data(contentsOf: path!, options: Data.ReadingOptions.mappedIfSafe)
        let countryData = JSON(data: jsonData!)
        
        for (_, subJson) in countryData["countries"] {
            if let dialCode = subJson["dial_code"].string, let name = subJson["name"].string, let code = subJson["code"].string {
                country.append(Country(code: code, dialCode: dialCode, name: name))
            }
        }
    }
    
    @objc private func handleDatePicker(_ sender: UIDatePicker) {
        expiryDateTextField.text = dateFortmatted(date: sender.date)
    }
    
    private func dateFortmatted(_ format: String? = nil, date: Date) -> String{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format ?? "dd MMM yyyy"
        return dateFormater.string(from: date)
    }
}

extension VerifyIDDetailVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return country.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return country[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryTextField.text = country[row].name
        selectedCode = country[row].dialCode
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: country[row].name, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
    
}
