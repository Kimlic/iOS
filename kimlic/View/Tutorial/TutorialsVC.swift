//
//  TutorialsVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 13.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import UIKit

class TutorialsVC: BaseVC, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageCount = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Registering PageViewController from StoryBoard
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        
        // PageViewContrller DataSource Method
        self.pageViewController.dataSource = self
        
        
        
        // Initialising the ViewController and setting ViewController to PageViewContrller
        let initialVC = self.contentViewAtIndex(0) as TutorialsContentVC
        self.pageViewController.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        
        
        // Setting the size of PageViewContrller
        self.pageViewController.view.frame = CGRect(x: 0, y: 30, width: self.view.frame.size.width, height: self.view.frame.size.height - 40)
        
        // Adding the PageViewContrller to the Parent View
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        let contentVC = viewController as! TutorialsContentVC
        var index = contentVC.pageIndex as Int

        if (index == 0 || index == NSNotFound){
            return nil
        }
        // Before ViewContrller, so we are (-) form the current index
        index -= 1

        return contentViewAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let contentVC = viewController as! TutorialsContentVC
        var index = contentVC.pageIndex as Int
        if (index == NSNotFound){
            return nil
        }
        // After ViewContrller, so we are (+) form the current index
        index += 1
        if(index == pageCount)
        {
            return nil
        }
        return self.contentViewAtIndex(index)
    }
    
    //Tutorials Present Page Count
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        setupPageControl()
        return pageCount
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = Constants.Colors.appBlue
    }
    
    //Tutorials Start Page Number
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        let currentViewController = self.pageViewController.viewControllers?.first
        let contentVC = currentViewController as! TutorialsContentVC
        let index = contentVC.pageIndex as Int
        return index
    }
    
    func contentViewAtIndex(_ index: Int) -> TutorialsContentVC{
        return createTutorialPage(pageIndex: index)
    }
    
    func createTutorialPage(pageIndex: Int!) -> TutorialsContentVC {
        let contentVC = self.storyboard?.instantiateViewController(withIdentifier: TutorialsContentVC.className) as! TutorialsContentVC
        contentVC.pageIndex = pageIndex
        switch pageIndex {
        case 0:
            contentVC.tutTitle = "tutorial1Title".localized
            contentVC.tutDesc = "tutorial1Desc".localized
            contentVC.image = #imageLiteral(resourceName: "scan_QR_iilustration")
        case 1:
            contentVC.tutTitle = "tutorial2Title".localized
            contentVC.tutDesc = "tutorial2Desc".localized
            contentVC.image = #imageLiteral(resourceName: "scan_QR_iilustration")
        case 2:
            contentVC.tutTitle = "tutorial3Title".localized
            contentVC.tutDesc = "tutorial3Desc".localized
            contentVC.image = #imageLiteral(resourceName: "scan_QR_iilustration")
        default:
            contentVC.tutTitle = "tutorial1Title".localized
            contentVC.tutDesc = "tutorial1Desc".localized
            contentVC.image = #imageLiteral(resourceName: "scan_QR_iilustration")
        }        
        return contentVC
    }
}
