//
//  MnemonicVerificationVC.swift
//  kimlic
//
//  Created by paltimoz on 10.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class MnemonicVerificationVC: UIViewController {
    
    
    @IBOutlet weak var firstPassphraseTextField: UITextField!
    @IBOutlet weak var secondPassphraseTextField: UITextField!
    @IBOutlet weak var thirdPassphraseTextField: UITextField!
    @IBOutlet weak var fourthPassphraseTextField: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    
    var randomVerifyList = [String]()
    var textFieldList = [UITextField]()
    fileprivate var tmpPassphrase = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default display
        setupView()
        
        // Set mnemonic passphrase
        setMnemonicArray()
        
        // Set text field array
        textFieldList = [firstPassphraseTextField, secondPassphraseTextField, thirdPassphraseTextField, fourthPassphraseTextField]

        // Set random passphrase
        setRandomPassphrase()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func verifyButtonPressed(_ sender: Any) {
        if verifyPassphrase() {
            UIUtils.navigateToMessage(self, messageType: .passphraseSuccessfull)
            Defaults[.recovery] = "Demo"
        }else {
            PopupGenerator.createPopup(controller: self, type: .warning, popup: Popup(title: "Wrong", message: "Passphrase Verify Wrong", buttonTitle: "Try Again"), btnClickCompletion: nil)
        }
    }
    
    fileprivate func setupView() {
        verifyButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.greenGradianteColors, frame: verifyButton.frame, type: .topBottom).color
    }
    
    fileprivate func setMnemonicArray() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        tmpPassphrase = appDelegate.quorumManager?.mnemonic.components(separatedBy: " ") ?? []
    }
    
    fileprivate func setRandomPassphrase() {
        
        // Randomly create 4 numbers from 0 to 12
        let randomIndexList = generateRandomUniqueNumbers()
        
        for index in 0...3 {
            let randomIndex = randomIndexList[index]
            // Create a passphrase list based on randomly assigned numbers
            randomVerifyList.insert(self.tmpPassphrase[randomIndex], at: index)
            
            // Placeholder is arranged according to randomly taken numbers
            setPlaceHolder(textFieldIndex: index, randomPassIndex: randomIndex)
        }
    }
    
    fileprivate func setPlaceHolder(textFieldIndex: Int, randomPassIndex: Int) {
        let randomPassSeq = randomPassIndex + 1
        switch randomPassSeq {
        case 1:
            textFieldList[textFieldIndex].placeholder = "\(randomPassSeq)st Word"
        case 2:
            textFieldList[textFieldIndex].placeholder = "\(randomPassSeq)nd Word"
        case 3:
            textFieldList[textFieldIndex].placeholder = "\(randomPassSeq)rd Word"
        default:
            textFieldList[textFieldIndex].placeholder = "\(randomPassSeq)th Word"
        }
    }
    
    fileprivate func generateRandomUniqueNumbers() -> [Int] {
        guard 4 <= (12) else { return [] }
        var numbers: Set<Int> = Set<Int>()
        (0..<4).forEach { _ in
            let beforeCount = numbers.count
            repeat {
                numbers.insert(Int(arc4random_uniform(12)))
            } while numbers.count == beforeCount
        }
        return numbers.map{ $0 }.sorted()
    }
    
    fileprivate func verifyPassphrase() -> Bool {
        for index in 0...3 {
            guard textFieldList[index].text == randomVerifyList[index] else {
                return false
            }
        }
        return true
    }
    
}
