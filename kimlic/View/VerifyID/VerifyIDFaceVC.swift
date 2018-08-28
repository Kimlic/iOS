//
//  VerifyIDFaceVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 27.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import UIKit

class VerifyIDFaceVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var croppedView: UIView!
    @IBOutlet weak var choseDocumentView: UIView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var driversLicanseButton: CustomButton!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var captureImageButton: UIButton!
    
    
    // MARK: - Local Varibles
    let cameraController = CameraController()
    var selectedDocumentType: DocumentType = .driversLicense
    lazy var documents: [VerificationDocument] = {
        let ver1 = VerificationDocument.init(contexts: [], countries: [], description: "ID Card", type: "ID_CARD")
        let ver2 = VerificationDocument.init(contexts: [], countries: [], description: "Driver License", type: "DRIVER_LICENSE")
        return [ver1, ver2]
    }()
    
    // MARK: - Overrides
    override var prefersStatusBarHidden: Bool { return false }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCameraController()
        
        createDocumentButtons()
        
        Animz.showMenu(myView: self.choseDocumentView, duration: 0.5, completion: {})
        
        
//        Animz.showMenu(myView: self.choseDocumentView, duration: 0.5, completion: {})
        
//        serverRequest {
//            Animz.showMenu(myView: self.choseDocumentView, duration: 0.5, completion: {})
//        }
    }
    
    // MARK: - IBActions
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func captureImageButtonPressed(_ sender: Any) {
        cameraController.captureImage {(image, error) in
            guard let image = image else {
                print(error ?? "Image capture error")
                return
            }
            let croppedImage = image.cropImage(toRect: self.croppedView.frame, viewWidth: self.view.frame.size.width, viewHeight: self.view.frame.size.height)
            UIUtils.navigateToVerifyID(self, profileImage: croppedImage)
        }
    }
    
    @IBAction func idCardButtonPressed(_ sender: Any) {
        setDocumentTypeAndView(type: .idCard)
    }
    @IBAction func driverLicenseButtonPressed(_ sender: Any) {
        setDocumentTypeAndView(type: .driversLicense)
    }
    @IBAction func passportButtonPressed(_ sender: Any) {
        setDocumentTypeAndView(type: .passport)
    }
    
    // MARK: - Functions
    
    private func configureCameraController() {
        cameraController.prepare {(error) in
            if let error = error {
                print(error)
            }
            try? self.cameraController.displayPreview(on: self.view)
        }
    }
    
    private func setDocumentTypeAndView(type: DocumentType) {
        selectedDocumentType = type
        Animz.hideMenu(myView: choseDocumentView, duration: 0.5) {
            self.choseDocumentView.isHidden = true
            self.bgImageView.isHidden = false
            self.captureImageButton.isHidden = false
        }
    }
    
    
}

// MARK: - Setup View and Web Serivce
extension VerifyIDFaceVC {
    
    private func setupView() {
        buttonsStackView.setBackgroundColor(colors: UIColor.verifyButtonsBlackGradiante, cornerRadius: 17)
//        driversLicanseButton.addBorder(side: .top, color: UIColor.seperatorGray, width: 1)
//        driversLicanseButton.addBorder(side: .bottom, color: UIColor.seperatorGray, width: 1)
    }
    
    private func serverRequest(completion: @escaping () -> () ) {
        CustomWebServiceRequest.getVerificationDocuments(success: { (documents) in
            self.documents = documents
            self.createDocumentButtons()
            completion()
        }) { (error) in
            // TODO: Error Popup
            print(error)
        }
    }
    
    private func createDocumentButtons() {
        for (index, document) in documents.enumerated() {
            let button = UIButton()
            button.setTitle(document.description, for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.tag = index
            button.backgroundColor = UIColor.clear
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            button.addTarget(self, action: #selector(VerifyIDFaceVC.selectDocumentButtonPressed), for: .touchUpInside)
            buttonsStackView.addArrangedSubview(button)
        }
    }
    
    @objc private func selectDocumentButtonPressed(_ sender: UIButton) {
        for (index, document) in documents.enumerated() {
            if index == sender.tag {
                selectedDocumentType = DocumentType(rawValue: document.type)!
            }
        }
    }
    
}

