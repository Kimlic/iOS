//
//  CustomPopupVC.swift
//  kimlic
//
//  Created by izzet öztürk on 29.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class CustomPopupVC: UIViewController {
    
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var closeButton: UIButton!
    
    fileprivate var popup: Popup!
    fileprivate var popupType: PopupType = .none
    private lazy var backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var rootVC: UIViewController!
    
    convenience required init(rootController: UIViewController, popupType: PopupType, popup: Popup? = nil) {
        self.init()
        self.rootVC = rootController
        self.popupType = popupType
        self.popup = popup
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create popup buttons
        createButtons()
        
        // Set defautl view
        setupView()
        
        // Set popup value
        setValue()
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setValue() {
        icon.image = popup.image
        titleLabel.text = popup.title
        descLabel.text = popup.message
    }
    
    fileprivate func setupView() {
        rootView.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.popupGrayGradianteColors, frame: rootView.frame, type: .topBottom).color
        pinBackground(backgroundView, to: buttonStackView)
    }
    
    fileprivate func createButtons() {
        for buttonModel in self.popup.buttons! {
            let button = UIButton()
            button.setTitle(buttonModel.title, for: .normal)
            button.tag = buttonModel.tag
            button.titleLabel?.font = UIFont.popupButtonText
            button.titleLabel?.textColor = UIColor.white
            button.backgroundColor = UIColor.clear
            let buttonHeightConstraint = button.heightAnchor.constraint(equalToConstant: 54.0)
            buttonHeightConstraint.isActive = true
            button.addTarget(self, action: #selector(popupButtonPressed), for: .touchUpInside)
//            button.addBottomBorderWithColor(color: UIColor.popupButtonBorderBlue, width: 0.5)
            button.layer.borderColor = UIColor.popupButtonBorderBlue.cgColor
            button.layer.borderWidth = 0.5
            buttonStackView.addArrangedSubview(button)
        }
    }
    
    // develop - Metod içi button işlevlerine göre düzenlenecek
    @objc func popupButtonPressed(sender: UIButton) {
        switch sender.tag {
        case 100:
            self.dismiss(animated: true)
            UIUtils.showPasscodeVC(vc: self.rootVC, pageType: .create)
        case 101:
            self.dismiss(animated: true)
            UIUtils.navigateToMnemonicCreate(self.rootVC)
        default:
            self.dismiss(animated: true)
        }
    }
    
    fileprivate func pinBackground(_ view: UIView, to stackView: UIStackView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(view, at: 0)
        view.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.blueGradianteColors, frame: stackView.frame, type: .topBottom).color
        view.pin(to: stackView)
    }

}
