//
//  PopupGenerator.swift
//  kimlic
//
//  Created by İzzet Öztürk on 16.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import UIKit
import PopupDialog

public class PopupGenerator {
    
    private static let btnCreatePasscode = ButtonModel(tag: 100, title: "Create Passcode")
    private static let btnEnableAccountRecovery = ButtonModel(tag: 101, title: "Enable Account Recovery")
    private static let btnCancel = ButtonModel(tag: 102, title: "Ok, Cancel")
    
    private static let icnWarning = UIImage(named: "warning_icon_with_circles")
    
    static func baseErrorPopup(controller: UIViewController, title: String, message: String) {
        let popup = Popup(title: title, message: message, image: icnWarning, buttonTitle: "Cancel")
        createPopupNew(controller: controller, type: .error, popup: popup)
    }
    
    static func baseCancelAlertPopup(controller: UIViewController, popup: Popup) {
        popup.buttons = [btnCancel]
        createPopupNew(controller: controller, type: .warning, popup: popup)
    }

    static func twoRisks(controller: UIViewController) {
        let myPopup = Popup(title: "Secure your Identity", message: "You have 2 security risks", image: icnWarning, buttons: [btnCreatePasscode, btnEnableAccountRecovery])
        createPopupNew(controller: controller, type: .none, popup: myPopup)
    }
    
    static func passcodeRisk(controller: UIViewController) {
        let myPopup = Popup(title: "Secure your Identity", message: "You have 1 security risk", image: icnWarning, buttons: [btnCreatePasscode])
        createPopupNew(controller: controller, type: .none, popup: myPopup)
    }
    
    static func recoveryRisk(controller: UIViewController) {
        let myPopup = Popup(title: "Secure your Identity", message: "You have 1 security risk", image: icnWarning, buttons: [btnEnableAccountRecovery])
        createPopupNew(controller: controller, type: .none, popup: myPopup)
    }
    
    private static func createPopupNew(controller: UIViewController, type: PopupType, popup: Popup) {
        // Create Content View Controller
        let content = CustomPopupVC(rootController: controller, popupType: .none, popup: popup)
        
        // Customize background overlay
        let overlayAppearance = PopupDialogOverlayView.appearance()
        overlayAppearance.color       = UIColor.black
        overlayAppearance.blurEnabled = false
        overlayAppearance.opacity     = 0.4
        
        // Create the dialog
        let popup = PopupDialog(viewController: content)
        popup.view.backgroundColor = UIColor.clear
        
        // Present popup
        controller.present(popup, animated: true, completion: nil)
    }
}
