//
//  VerifyIDVC.swift
//  kimlic
//
//  Created by izzet öztürk on 30.07.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import UIKit
import AVFoundation

// TODO: integrate general CameraController class
class VerifyIDVC: UIViewController {
    
    @IBOutlet weak var bgImage: UIImageView!
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
    
    var activePage: ActivePage = .front
    var verifyIDModel: VerifyIDModel!
    
    enum ActivePage {
        case front, back
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup AVFoundation Camera
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }
    
    // MARK: - IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        UIUtils.setUserProfileScreenAsRoot()
    }
    
    @IBAction func takePhotoButtonPressed(_ sender: Any) {
        takePhoto()
    }
    
    
    // MARK: - Functions
    
    private func takePhoto() {
        UIUtils.showLoading()
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                             kCVPixelBufferWidthKey as String: 160,
                             kCVPixelBufferHeightKey as String: 160]
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
        currentCamrera = backCamera ?? frontCamera
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

}

extension VerifyIDVC: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            activePageSettings(dataImage)
        }
        UIUtils.stopLoading()
    }
    
    private func activePageSettings(_ photoData: Data?) {
        
        guard let photo = UIImage(data: photoData!)?.cropImage(toRect: croppedView.frame, viewWidth: self.view.frame.width, viewHeight: self.view.frame.height) else {
            return
        }
        
        switch activePage {
        case .front:
            activePage = .back
            verifyIDModel?.documentFrontImage = photo
            if let contexts = verifyIDModel.documentType?.contexts, contexts.contains(DocumentPhotoContext.documentBack.rawValue) {
                rotateBack()
            }else {
                UIUtils.navigateToVerifyIDDetail(self, model: verifyIDModel)
            }
        default:
            verifyIDModel?.documentBackImage = photo
            UIUtils.navigateToVerifyIDDetail(self, model: verifyIDModel)
        }
    }
    
    private func rotateBack() {
        Animz.rotateY(layer: activePageImage.layer, angleFrom: 360, duration: 0.4) {
            self.activePageImage.image = UIImage(named: "camera_Screen_card_backside_icon")
        }
        activePageLabel.text = "Back Side"
        Animz.fadeIn(view: activePageLabel, duration: 0.4)
    }
}
