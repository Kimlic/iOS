//
//  VerifyIDFaceVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 27.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import UIKit
import AVKit

// TODO: integrate general CameraController class
class VerifyIDFaceVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var croppedView: UIView!
    @IBOutlet weak var choseDocumentView: UIView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var captureImageButton: UIButton!
    @IBOutlet weak var switchCameraButton: UIButton!
    
    
    // MARK: - Local Varibles
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamrera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var selectedDocument: VerificationDocument!
    lazy var documents: [VerificationDocument] = [VerificationDocument]()
    
    // MARK: - Overrides
    override var prefersStatusBarHidden: Bool { return false }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Camera Config
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        
        serverRequest {
            Animz.showMenu(myView: self.choseDocumentView, duration: 0.5, completion: {})
        }
    }
    
    // MARK: - IBActions
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func captureImageButtonPressed(_ sender: Any) {
        takePhoto()
    }
    
    // MARK: - Functions
    
    private func takePhoto() {
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType]
        settings.previewPhotoFormat = previewFormat
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    private func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    private func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        currentCamrera = frontCamera ?? backCamera
    }
    
    private func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamrera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    
    private func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    private func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    private func setDocumentTypeAndView(_ document: VerificationDocument) {
        selectedDocument = document
        Animz.hideMenu(myView: choseDocumentView, duration: 0.5) {
            self.choseDocumentView.isHidden = true
            self.bgImageView.isHidden = false
            self.captureImageButton.isHidden = false
        }
    }
}

// MARK: - Setup View and Web Serivce
extension VerifyIDFaceVC {
    
    private func serverRequest(completion: @escaping () -> () ) {
        UIUtils.showLoading()
        CustomWebServiceRequest.getVerificationDocuments(success: { (documents) in
            UIUtils.stopLoading()
            self.documents = documents
            self.createDocumentButtons()
            completion()
        }) { (error) in
            UIUtils.stopLoading()
            // TODO: Error Popup
            print(error)
        }
    }
    
    private func createDocumentButtons() {
        for (index, document) in documents.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(document.description, for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.popupButtonText
            button.tag = index
            button.backgroundColor = UIColor.clear
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            let buttonHeightConstraint = button.heightAnchor.constraint(equalToConstant: 56.0)
            buttonHeightConstraint.isActive = true
            button.layer.cornerRadius = 6
            button.addTarget(self, action: #selector(VerifyIDFaceVC.selectDocumentButtonPressed), for: .touchUpInside)
            buttonsStackView.addArrangedSubview(button)
        }
    }
    
    @objc private func selectDocumentButtonPressed(_ sender: UIButton) {
        for (index, document) in documents.enumerated() {
            if index == sender.tag {
                setDocumentTypeAndView(document)
            }
        }
    }
}

extension VerifyIDFaceVC: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            guard let image = UIImage(data: dataImage) else {
                return
            }
            let croppedImage = image.cropImage(toRect: self.croppedView.frame, viewWidth: self.view.frame.size.width, viewHeight: self.view.frame.size.height)
            var verifyIDModel = VerifyIDModel()
            verifyIDModel.faceImage = croppedImage
            verifyIDModel.documentType = selectedDocument
            UIUtils.navigateToVerifyID(self, model: verifyIDModel)
        }
    }
    
}



