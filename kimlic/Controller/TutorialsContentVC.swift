//
//  TutorialsContentVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 13.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import UIKit

class TutorialsContentVC: UIViewController {
    
    
    @IBOutlet weak var tutorialImage: UIImageView!
    @IBOutlet weak var tutorialTitle: UILabel!
    @IBOutlet weak var tutorialDesc: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnGenerateCode: UIButton!
    
    @IBOutlet weak var viewContent: UIView!
    
    var pageIndex:Int!
    var pageCount: Int!
    var tutTitle: String!
    var tutDesc: String!
    var imageName: String!
    
    var pageViewController: UIPageViewController!
    var controller: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Font size is set to prevent screen overflow in 5s devices
        if AppDelegate.isIPhone5s() {
            tutorialTitle.font = UIFont(name: tutorialTitle.font.fontName, size: 20)
            tutorialDesc.font = UIFont(name: tutorialTitle.font.fontName, size: 14)
            
            self.view.addConstraint(NSLayoutConstraint(item: btnGenerateCode, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.viewContent, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 15))
            
            self.viewContent.addConstraint(NSLayoutConstraint(item: tutorialImage, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.viewContent, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: -20))
            
        }else if AppDelegate.isTablet() {
            
            tutorialTitle.font = UIFont(name: tutorialTitle.font.fontName, size: 16)
            tutorialDesc.font = UIFont(name: tutorialTitle.font.fontName, size: 12)
            
            self.viewContent.addConstraint(NSLayoutConstraint(item: tutorialImage, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.viewContent, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: -30))
            
            self.view.addConstraint(NSLayoutConstraint(item: btnNext, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.viewContent, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 30))
            
        }
        
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        controller = self
        
        setTutorialFieldsValue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        Animz.fadeIn(image: tutorialImage, duration: Animz.time06)
    }
    
    
    @IBAction func btnNextPressed(_ sender: Any) {
        if pageIndex == pageCount-1 {
            UIUtils.confirmTouchID(controller: self, targetController: .UserBasicProfileVC, qrCode:nil)
        }else {
            //ibrahim - prevent double click on next button
            self.pageViewController.view.isUserInteractionEnabled = false
            
            guard let currentViewController = self.pageViewController.viewControllers?.first else { return }
            guard let nextViewController = self.pageViewController.dataSource?.pageViewController( self.pageViewController, viewControllerAfter: currentViewController ) else { return }
            self.pageViewController.setViewControllers([nextViewController], direction: .forward, animated: true, completion: { (result) in
                self.pageViewController.view.isUserInteractionEnabled = true
            })
        }
    }
    
    
    @IBAction func btnGenerateCodePressed(_ sender: Any) {
        UIUtils.presentVerificationCodeVC(vc: self, pageType: .create, qrCode: nil)        
    }
    
    func setTutorialFieldsValue() {
        
        //Next button is changed on the last page
        if pageIndex == pageCount-1 {
            btnNext.backgroundColor = Constants.Colors.appGreen
            btnNext.setImage(UIImage(named:"white_finger_print_icon"), for: .normal)
            btnNext.setTitle("useTouchID".localized, for: .normal)
            btnGenerateCode.isHidden = false
        }else {
            self.view.addConstraint(NSLayoutConstraint(item: btnNext, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.viewContent, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0))
            btnNext.backgroundColor = Constants.Colors.appBlue
            btnGenerateCode.isHidden = true
        }
        tutorialImage.image = UIImage(named: imageName)
        tutorialTitle.text = tutTitle
        tutorialDesc.text = tutDesc        
    }
    
}
