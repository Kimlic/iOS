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
    
    // MARK: - Overrides
    override var prefersStatusBarHidden: Bool { return false }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCameraController()
        
        setupView()
        
        Animz.showMenu(myView: choseDocumentView, duration: 0.5, completion: {})
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
    
    private func setupView() {
        buttonsStackView.setBackgroundColor(colors: UIColor.verifyButtonsBlackGradiante, cornerRadius: 17)
        driversLicanseButton.addBorder(side: .top, color: UIColor.seperatorGray, width: 1)
        driversLicanseButton.addBorder(side: .bottom, color: UIColor.seperatorGray, width: 1)
    }
    
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
