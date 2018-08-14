//
//  ScanCodeVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 21.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.

import UIKit
import AVFoundation

class QRCodeVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var scanAreaView: UIView!
    @IBOutlet weak var cancelButton: CustomButton!
    
    // MARK: - Local Varibles
    
    var video = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        // Set QRCode Reader Config
        setupQRCodeReader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !session.isRunning {
            session.startRunning()
        }
        
        // Scan area animation
        scanAreaAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if session.isRunning {
            session.stopRunning()
        }
        scanAreaView.layer.removeAllAnimations()
    }
    
    // MARK: - IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    
    private func setupView() {
        cancelButton.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.cancelButtonGrayGradiante, frame: cancelButton.frame, type: .topBottom).color
    }
    
    private func setupQRCodeReader() {
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do{
            let input  = try AVCaptureDeviceInput(device: captureDevice!)
            self.session.addInput(input)
        }catch {
            // TODO: Error Popup
        }
        
        // Set AVCaptureMetadataOutput value
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        // Set AVCaptureVideoPreviewLayer value
        video = AVCaptureVideoPreviewLayer(session: self.session)
        video.frame = self.view.layer.bounds
        cameraView.layer.addSublayer(video)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        
        // Start camera
        session.startRunning()
        
    }
    
    private func scanAreaAnimation() {
        let scanLineView = UIView(frame: CGRect(x: 0, y: 0, width: scanAreaView.frame.size.width, height: 3))
        scanLineView.backgroundColor = UIColor.lightBlueGrey
        scanAreaView.addSubview(scanLineView)
        
        // Start barcode line animation
        startLineAnimation(scanLineView)
    }
    
    private func startLineAnimation(_ lineView: UIView) {
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            lineView.frame.origin.y += self.scanAreaView.frame.size.height
        }, completion: { (finished) in
            if finished {
                UIView.animate(withDuration: 2.0, animations: {
                    lineView.frame.origin.y -= self.scanAreaView.frame.size.height
                })
            }
        })
    }
}

extension QRCodeVC: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        guard metadataObjects.count > 0, let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {
            return
        }
        guard object.type == AVMetadataObject.ObjectType.qr else {
            return
        }
        
        let barcodeObject = video.transformedMetadataObject(for: object)
        
        guard (barcodeObject?.bounds.origin.x)! >= scanAreaView.frame.origin.x,
            (barcodeObject?.bounds.origin.y)! >= scanAreaView.frame.origin.y,
            (scanAreaView.frame.size.width + scanAreaView.frame.origin.x) >= ((barcodeObject?.bounds.size.width)! + (barcodeObject?.bounds.origin.x)!),
            (scanAreaView.frame.size.height + scanAreaView.frame.origin.y ) >= ((barcodeObject?.bounds.size.height)! + (barcodeObject?.bounds.origin.y)!) else {
                return
        }
        guard let value = object.stringValue else {
            return
        }
        session.stopRunning()
        
        // TODO: Navigate Page and Remove Areal
        let alert = UIAlertController(title: "QR Code", message: value, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (nil) in
            self.session.startRunning()
        }))
        
        present(alert, animated: true, completion: nil)
        // todo end
    }
    
}
