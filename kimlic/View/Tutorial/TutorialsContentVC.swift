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
    @IBOutlet weak var skipButton: UIButton!
    
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
        
        self.controller = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        Animz.fadeIn(image: tutorialImage, duration: Animz.time06)
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        if pageIndex == pageCount-1 {
            UIUtils.navigateToTerms(self)
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
}
