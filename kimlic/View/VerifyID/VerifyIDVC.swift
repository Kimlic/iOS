//
//  VerifyIDVC.swift
//  kimlic
//
//  Created by izzet öztürk on 30.07.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import UIKit
import AVFoundation

class VerifyIDVC: UIViewController {
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var choseDocumentView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var activePageImage: UIImageView!
    @IBOutlet weak var activePageLabel: UILabel!
    @IBOutlet weak var croppedView: UIView!
    
    // MARK: Local Variables
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamrera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var image: UIImage?
    
    var selectedDocumentType: DocumentType = .driverLicense
    var activePage: ActivePage = .front
    var cardFrontPhotoData: Data?
    var cardBackPhotoData: Data?
    
    enum DocumentType {
        case idCard, driverLicense, passport
    }
    
    enum ActivePage {
        case front, back
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

        // Setup AVFoundation Camera
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }
    
    // MARK: - IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        Animz.hideMenu(myView: choseDocumentView, duration: 0.5) {}
    }
    @IBAction func idCardButtonPressed(_ sender: Any) {
        setDocumentTypeAndView(type: .idCard)
    }
    @IBAction func driverLicenseButtonPressed(_ sender: Any) {
        setDocumentTypeAndView(type: .driverLicense)
    }
    @IBAction func passportButtonPressed(_ sender: Any) {
        setDocumentTypeAndView(type: .passport)
    }
    @IBAction func takePhotoButtonPressed(_ sender: Any) {
        takePhoto()
    }
    
    
    // MARK: - Functions
    
    private func setupView() {
        Animz.showMenu(myView: choseDocumentView, duration: 0.5) {}
    }
    
    private func setDocumentTypeAndView(type: DocumentType) {
        selectedDocumentType = type
        Animz.hideMenu(myView: choseDocumentView, duration: 0.5) {
            self.contentView.isHidden = false
            self.choseDocumentView.isHidden = true
        }
    }
    
    fileprivate func takePhoto() {
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType]
        settings.previewPhotoFormat = previewFormat
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    fileprivate func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    fileprivate func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        currentCamrera = backCamera ?? frontCamera
    }
    
    fileprivate func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamrera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    
    fileprivate func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    fileprivate func startRunningCaptureSession() {
        captureSession.startRunning()
    }

}

extension VerifyIDVC: AVCapturePhotoCaptureDelegate {
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            //            let image = UIImage(data: dataImage)?.resizeImage(size: CGSize(width: (self.viewIfLoaded?.frame.size.width)!, height: (self.viewIfLoaded?.frame.size.height)! * 0.5))
            let image = UIImage(data: dataImage)
            if let photo = cropImage(image!, toRect: croppedView.frame, viewWidth: croppedView.frame.width, viewHeight: croppedView.frame.height) {
                CoreDataHelper.saveVerifyCardPhoto(frontPhoto: photo.getImageData(), backPhoto: photo.getImageData())
            }
            UIUtils.navigateToVerifyIDDetail(self)
        }
    }
    
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
//        if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
//            activePageSettings(dataImage)
//        }
//    }
    
//    private func activePageSettings(_ photoData: Data?) {
//        guard let photo = cropImage(UIImage(data: photoData!)!, toRect: croppedView.frame, viewWidth: croppedView.frame.width, viewHeight: croppedView.frame.height) else {
//            return
//        }
//        switch activePage {
//        case .front:
//            Animz.rotateY(layer: activePageImage.layer, angleFrom: 360, duration: 0.4) {
//                self.activePageImage.image = UIImage(named: "camera_Screen_card_backside_icon")
//            }
//            activePageLabel.text = "Back Side of the document"
//            activePage = .back
//            cardFrontPhotoData = photo.getImageData()
//        default:
//            activePage = .front
//            cardBackPhotoData = photo.getImageData()
//            saveData()
//        }
//    }
    
    // TODO: Call Web Service
    private func saveData() {
        UIUtils.showLoading()
        
        // Call Web Service
        
        CoreDataHelper.saveVerifyCardPhoto(frontPhoto: cardFrontPhotoData, backPhoto: cardBackPhotoData)
        UIUtils.stopLoading()
        UIUtils.navigateToVerifyIDDetail(self)
    }
    
    func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) -> UIImage?
    {
        let imageViewScale = max(inputImage.size.width / viewWidth,
                                 inputImage.size.height / viewHeight)
        
        // Scale cropRect to handle images larger than shown-on-screen size
        let cropZone = CGRect(x: cropRect.origin.x,
                              y: cropRect.origin.y,
                              width: cropRect.size.width * imageViewScale,
                              height: cropRect.size.height * imageViewScale)
        
        // Perform cropping in Core Graphics
        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropZone)
            else {
                return nil
        }
        
        // Return image to UIImage
        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        return croppedImage
    }
}
