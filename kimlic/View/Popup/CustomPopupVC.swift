//
//  CustomPopupVC.swift
//  kimlic
//
//  Created by izzet öztürk on 29.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set defautl view
        setupView()
        
        // Set popup value
//        setValue()
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
    
    @IBAction func createPasscodeButtonPressed(_ sender: Any) {
        UIUtils.showPasscodeVC(vc: self, pageType: .create) {
            UIUtils.navigateToMessage(self, messageType: .pascodeSuccessfull)
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    convenience required init(popupType: PopupType, popup: Popup? = nil) {
        self.init()
        self.popupType = popupType
        self.popup = popup
    }
    
    private func pinBackground(_ view: UIView, to stackView: UIStackView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(view, at: 0)
        view.backgroundColor = GradiantColor.convertGradientToColour(colors: UIColor.popupBlueGradianteColors, frame: self.buttonStackView.bounds, type: .topBottom).color
        view.pin(to: stackView)
    }

}
