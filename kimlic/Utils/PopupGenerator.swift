//
//  PopupGenerator.swift
//  kimlic
//
//  Created by İzzet Öztürk on 16.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import UIKit
import PopupDialog

class PopupGenerator {
    
    static func createPopup(controller: UIViewController, type: PopupType, popup: Popup, btnClickCompletion: (() -> ())? = nil) {
        
        
        var popupDialog: PopupDialog!
        var button: DefaultButton!
        
        // Customize the container view appearance
        let pcv = PopupDialogContainerView.appearance()
        pcv.cornerRadius    = 20
        
        let dialogAppearance = PopupDialogDefaultView.appearance()
        
        dialogAppearance.backgroundColor      = UIColor.white
        dialogAppearance.titleFont            = UIFont.boldSystemFont(ofSize: 30)
        dialogAppearance.titleColor           = Constants.Colors.popupTitleDarkGrey
        dialogAppearance.titleTextAlignment   = .center
        dialogAppearance.messageFont          = UIFont.systemFont(ofSize: 22)
        dialogAppearance.messageColor         = Constants.Colors.popupMsgGrey
        dialogAppearance.messageTextAlignment = .center
        
        
        // Customize default button appearance
        let defaultButton = DefaultButton.appearance()
        defaultButton.titleFont      = UIFont.boldSystemFont(ofSize: 30)
        defaultButton.buttonColor    = UIColor(white: 0.95, alpha: 1)
        defaultButton.separatorColor = UIColor(white: 0.95, alpha: 1)
        
        // ibrahim - customize background overlay
        let overlayAppearance = PopupDialogOverlayView.appearance()
        overlayAppearance.color       = UIColor.black
        overlayAppearance.blurEnabled = false
        overlayAppearance.liveBlur    = false
        overlayAppearance.opacity     = 0.3
        
        
        switch type {
            
        case .error:
            
            if popup.title == nil {
                popup.title = "errorTitle".localized
            }
            
            if popup.message == nil {
                popup.message = "errorMessage".localized
            }
            
            if popup.image == nil {
                popup.image = UIImage(named: "Error_popup_illustration")
            }
            
            if popup.buttonTitle == nil {
                popup.buttonTitle = "errorButtonTitle".localized
            }
            
            popupDialog = PopupDialog(title: popup.title, message: popup.message, image: popup.image, gestureDismissal: false)
            
            button = DefaultButton(title: popup.buttonTitle!, height: 80) {
                btnClickCompletion?()
                return
            }
            defaultButton.titleColor     = Constants.Colors.popupErrorRed
            popupDialog.addButton(button)
            
            break
            
        case .warning:
            
            if popup.title == nil {
                popup.title = "warningTitle".localized
            }
            
            if popup.message == nil {
                popup.message = "warningMessage".localized
            }
            
            if popup.image == nil {
                popup.image = UIImage(named: "Warning_popup_illustration")
            }
            
            if popup.buttonTitle == nil {
                popup.buttonTitle = "warningButtonTitle".localized
            }
            
            popupDialog = PopupDialog(title: popup.title, message: popup.message, image: popup.image, gestureDismissal: false)
            
            button = DefaultButton(title: popup.buttonTitle!, height: 80) {
                btnClickCompletion?()
                return
            }
            defaultButton.titleColor     = Constants.Colors.popupWarningOrange
            popupDialog.addButton(button)
            
            // Logout popup for Cancel button
            if let cancel = popup.cancelButton, cancel {
                let cancelType = CancelButton.appearance()
                cancelType.titleFont      = UIFont.boldSystemFont(ofSize: 30)
                cancelType.buttonColor    = UIColor(white: 0.95, alpha: 1)
                cancelType.separatorColor = UIColor(white: 0.95, alpha: 1)
                let cancelButton = CancelButton(title: "Cancel", height: 80, dismissOnTap: true, action: nil)
                popupDialog.addButton(cancelButton)
            }
            break
            
        case .success:
            
            if popup.title == nil {
                popup.title = "successTitle".localized
            }
            
            if popup.message == nil {
                popup.message = "successMessage".localized
            }
            
            if popup.image == nil {
                popup.image = UIImage(named: "Success_popup_illustration")
            }
            
            if popup.buttonTitle == nil {
                popup.buttonTitle = "successButtonTitle".localized
            }
            
            popupDialog = PopupDialog(title: popup.title, message: popup.message, image: popup.image, gestureDismissal: false)
            
            button = DefaultButton(title: popup.buttonTitle!, height: 80) {
                btnClickCompletion?()
                return
            }
            defaultButton.titleColor     = Constants.Colors.popupSuccessGreen
            popupDialog.addButton(button)
            
            break
            
        case .qrcode:
            
            if popup.title == nil {
                popup.title = "qrCodeTitle".localized
            }
            
            if popup.message == nil {
                popup.message = "qrCodeMessage".localized
            }
            
            if popup.image == nil {
                popup.image = UIImage(named: "scan_QR_iilustration")
            }
            
            if popup.buttonTitle == nil {
                popup.buttonTitle = "qrCodeButtonTitle".localized
            }
            
            
            popupDialog = PopupDialog(title: popup.title, message: popup.message, image: popup.image, gestureDismissal: false)
            
            button = DefaultButton(title: popup.buttonTitle!, height: 80) {
                btnClickCompletion?()
                return
            }
            defaultButton.titleColor     = Constants.Colors.appBlue
            popupDialog.addButton(button)
            
            break
            
        }
        
        popupDialog.transitionStyle = PopupDialogTransitionStyle.zoomIn
        
        controller.present(popupDialog, animated: true, completion: nil)

    }
    
    
}
