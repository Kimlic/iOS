//
//  MnemonicCreateVC.swift
//  kimlic
//
//  Created by paltimoz on 10.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

class MnemonicCreateVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var saveButton: UIButton!
    
    private var tmpPassphrase = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default display
        setupView()
        
        // Set mnemonic passphrase
        setMnemonicArray()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        UIUtils.navigateToMnemonicVerification(self)
    }
    
    private func setupView() {
        saveButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.blueGradianteColors, frame: saveButton.frame, type: .topBottom).color
    }
    
    private func setMnemonicArray() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        tmpPassphrase = appDelegate.quorumManager?.mnemonic.components(separatedBy: " ") ?? []
    }
}

extension MnemonicCreateVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tmpPassphrase.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PassCell", for: indexPath)
        let passLabel = cell.viewWithTag(101) as! UILabel
        let numberLabel = cell.viewWithTag(100) as! UILabel
        passLabel.text = "\(tmpPassphrase[indexPath.row])"
        numberLabel.text = "\(indexPath.row + 1)"
        return cell
    }
}

extension MnemonicCreateVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  30
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 30)
    }
    
}
