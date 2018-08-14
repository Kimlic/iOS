//
//  TutorialsContentVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 13.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import UIKit

class TutorialsContentVC: UIViewController {
    
    @IBOutlet weak var tutorialImage: UIImageView!
    @IBOutlet weak var tutorialIcon: UIImageView!
    @IBOutlet weak var tutorialTitle: UILabel!
    @IBOutlet weak var tutorialDesc: UILabel!
    @IBOutlet weak var verticalConstraint: NSLayoutConstraint!
    
    var tutTitle: String!
    var tutDesc: String!
    var image: UIImage!
    var icon: UIImage!
    var pageIndex:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setTutorialFieldsValue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        Animz.fadeIn(image: tutorialImage, duration: Animz.time06)
    }
    
    private func setupView() {
        if AppDelegate.isIPhone5s() {
            DispatchQueue.main.async {
                self.verticalConstraint.constant = -75
            }
        }
        self.view.backgroundColor = UIColor.clear
    }
    
    func setTutorialFieldsValue() {
        tutorialImage.image = image
        tutorialIcon.image = icon
        tutorialTitle.text = tutTitle
        tutorialDesc.text = tutDesc
    }
    
}
