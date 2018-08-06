//
//  AddressVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 3.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import UIKit
import GooglePlaces
import FileBrowser

class AddressVC: UIViewController {
    
    // MARK: - IBOutles
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addFileButton: UIButton!
    @IBOutlet weak var uploadFileImageView: UIImageView!
    
    // MARK: - Local Varibles
    var uploadFile: Data?
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        setupView()
    }
    
    // MARK: - IBActions
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Present the Autocomplete view controller when the button is pressed.
    @IBAction func addressSearchButtonPressed(_ sender: UIButton) {
        UIUtils.navigateToAddressSearch(self) { (response) in
            self.addressTextField.text = response.attributedFullText.string
        }
    }
    
    @IBAction func addFileButtonPressed(_ sender: Any) {
        showActionSheet()
    }
    
    // MARK: - Functions
    
    private func setupView() {
        saveButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.greenGradianteColors, frame: saveButton.frame, type: .topBottom).color
        addFileButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.blueGradianteColors, frame: addFileButton.frame, type: .topBottom).color
    }
    
    private func showActionSheet() {
        
        let optionMenu = UIAlertController(title: nil, message: "Upload File", preferredStyle: .actionSheet)
        
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (alert: UIAlertAction!) in
            self.takePhotoHandler()
        }
        
        let gallery = UIAlertAction(title: "Gallery", style: .default) { (alert: UIAlertAction!) in
            self.galleryUploadHandler()
        }
        
        let browse = UIAlertAction(title: "Browse File", style: .default) { (alert: UIAlertAction!) in
            self.browseFileHandler()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(gallery)
        optionMenu.addAction(browse)
        optionMenu.addAction(cancel)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    private func takePhotoHandler() {
        //Camera settings are made
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func galleryUploadHandler() {
        //Camera settings are made
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    private func browseFileHandler() {
        let fileBrowser = FileBrowser()
        self.present(fileBrowser, animated: true, completion: nil)
        fileBrowser.didSelectFile = { (file: FBFile) -> Void in
            print(file.displayName)
        }
    }

}

extension AddressVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        uploadFile = image?.getImageData()
        uploadFileImageView.image = image
        dismiss(animated:true, completion: nil)
    }
}
