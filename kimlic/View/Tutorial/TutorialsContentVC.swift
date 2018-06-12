//
//  TutorialsContentVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 13.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import UIKit

class TutorialsContentVC: UIViewController {
    
    @IBOutlet weak var tutorialImage: UIImageView!
    @IBOutlet weak var tutorialTitle: UILabel!
    @IBOutlet weak var tutorialDesc: UILabel!
    @IBOutlet weak var viewContent: UIView!

    var tutTitle: String!
    var tutDesc: String!
    var image: UIImage!
    var pageIndex:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTutorialFieldsValue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        Animz.fadeIn(image: tutorialImage, duration: Animz.time06)
    }
    
    func setTutorialFieldsValue() {
        tutorialImage.image = image
        tutorialTitle.text = tutTitle
        tutorialDesc.text = tutDesc
    }
    
}
