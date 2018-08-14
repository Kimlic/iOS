//
//  ProfileCamera.swift
//  kimlic
//
//  Created by ibrahim özdemir on 10.07.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//
import UIKit
import AVFoundation

class ProfileCameraVC: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var croppedView: UIView!
    
    // MARK: Local Variables
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamrera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var image: UIImage?
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }
    
    // MARK: Actions
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func takePhotoButtonPressed(_ sender: Any) {
        takePhoto()
    }
    
    // MARK: Functions
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
        currentCamrera = frontCamera ?? backCamera
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

extension ProfileCameraVC: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            let image = UIImage(data: dataImage)
            var custumCroppedRect  = croppedView.frame
            custumCroppedRect.origin.y -= 20
            custumCroppedRect.size.height += 40
            custumCroppedRect.origin.x -= 40
            custumCroppedRect.size.width += 80
            if let photo = image?.cropImage(toRect: custumCroppedRect, viewWidth: self.view.frame.width, viewHeight: self.view.frame.height) {
                CoreDataHelper.saveProfilePhoto(photo: photo.getImageData())
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}



