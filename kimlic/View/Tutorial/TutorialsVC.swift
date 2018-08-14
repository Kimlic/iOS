//
//  TutorialsVC.swift
//  kimlic
//
//  Created by İzzet Öztürk on 13.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import UIKit

class TutorialsVC: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageCount = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupPageViewController()
    }
    
    /*
     * @discussion Pager and PageVC set default value
     * @param
     * @return
     */
    fileprivate func setupPageViewController() {
        
        // Registering PageViewController from StoryBoard
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        
        let pageControl: UIPageControl = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        pageControl.pageIndicatorTintColor = UIColor.pagerBlue
        pageControl.currentPageIndicatorTintColor = UIColor.white
        
        // PageViewContrller DataSource Method
        pageViewController.dataSource = self
        
        // Initialising the ViewController and setting ViewController to PageViewContrller
        let initialVC = self.contentViewAtIndex(0) as TutorialsContentVC
        pageViewController.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        
        // Setting the size of PageViewContrller
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 60)
        
        // Adding the PageViewContrller to the Parent View
        addChildViewController(self.pageViewController)
        view.addSubview(self.pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
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
        appearance.currentPageIndicatorTintColor = UIColor.waterBlue
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
            contentVC.image = #imageLiteral(resourceName: "tutorial_1_illustration")
            contentVC.icon = #imageLiteral(resourceName: "profile_icon_for_tutorial")
        case 1:
            contentVC.tutTitle = "tutorial2Title".localized
            contentVC.tutDesc = "tutorial2Desc".localized
            contentVC.image = #imageLiteral(resourceName: "tutorial_2_illustration")
            contentVC.icon = #imageLiteral(resourceName: "scan_icon_for_tutorial")
        case 2:
            contentVC.tutTitle = "tutorial3Title".localized
            contentVC.tutDesc = "tutorial3Desc".localized
            contentVC.image = #imageLiteral(resourceName: "tutorial_3_illustration")
            contentVC.icon = #imageLiteral(resourceName: "account_icon_for_tutorial")
        default:
            contentVC.tutTitle = "tutorial1Title".localized
            contentVC.tutDesc = "tutorial1Desc".localized
            contentVC.image = #imageLiteral(resourceName: "tutorial_1_illustration")
            contentVC.icon = #imageLiteral(resourceName: "profile_icon_for_tutorial")
        }        
        return contentVC
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        UIUtils.navigateToTerms(self, nextPage: .phoneNumber)
    }
    
}
