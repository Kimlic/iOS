//
//  ProfileCamera.swift
//  kimlic
//
//  Created by ibrahim özdemir on 10.07.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit
import AVFoundation


class ProfileCameraVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate  {
   
    @IBOutlet weak var cameraView: UIView!
    
    var video = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
    let photoOutput = AVCapturePhotoOutput()

    
    @IBAction func TakePhoto(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do{
           let videoDevices = AVCaptureDevice.devices(for: AVMediaType.video)
            var captureDevice: AVCaptureDevice?
            for device in videoDevices {
                if device.position == AVCaptureDevice.Position.front {
                    captureDevice = device
                    break
                }
            }
            
            let input  = try AVCaptureDeviceInput(device: captureDevice!)
            self.session.addInput(input)
        }catch {
            print("Error")
        }
        let output = AVCaptureMetadataOutput()
        self.session.addOutput(output)
        self.video = AVCaptureVideoPreviewLayer(session: self.session)
        self.video.frame = self.view.layer.bounds
        self.cameraView.layer.addSublayer(self.video)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        self.session.startRunning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !session.isRunning {
            session.startRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        UIUtils.showLoading()
        guard let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {
            UIUtils.stopLoading()
            session.stopRunning()
            PopupGenerator.createPopup(controller: self, type: .error, popup: Popup(), btnClickCompletion: {
                self.session.startRunning()
            })
            return
        }
        guard object.type == AVMetadataObject.ObjectType.qr else {
            UIUtils.stopLoading()
            session.stopRunning()
            PopupGenerator.createPopup(controller: self, type: .error, popup: Popup(), btnClickCompletion: {
                self.session.startRunning()
            })
            return
        }
        if let value = object.stringValue {
            
            session.stopRunning()
            guard let appId = value.getAppIdFromQrCode(), let _ = Int(appId), let token = value.getToken(), token.count > 1 else {
                UIUtils.stopLoading()
                PopupGenerator.createPopup(controller: self, type: .warning, popup: Popup(title: "wrongQrTitle".localized, message: "wrongQrMessage".localized, buttonTitle: "wrongQrButtonTitle".localized), btnClickCompletion: {
                    self.session.startRunning()
                })
                return
            }
            
            QrCodeWebServiceRequest().getApplicationDetail(appId: appId, completion: { (permissionResponse) in
                if permissionResponse != nil {
                    UIUtils.stopLoading()
                    UIUtils.navigateToPermissionDetail(vc: self, permission: permissionResponse!, qrCode: value)
                }else {
                    UIUtils.stopLoading()
                    PopupGenerator.createPopup(controller: self, type: .error, popup: Popup(), btnClickCompletion: {
                        self.session.startRunning()
                    })
                }
            })
            
        }
    }
    
    func btnBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
