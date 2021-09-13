//
//  HomeResearchesController.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.02.2021.
//


import UIKit
import Pageboy

final class HomeResearchesController: PageboyViewController {
    
    @IBOutlet var mainView: UIView!
//    @IBOutlet weak var lineView: UIView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    lazy var viewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        for i in 0 ..< ResourcesService.allResourcesList().count {
            viewControllers.append(makeChildViewController(at: i))
        }
        return viewControllers
    }()

    var researchesDelegate: NavigateDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        self.view.clipsToBounds = true
//        lineView.backgroundColor = StyleManager.colors.lineColor
        pageControl.numberOfPages = ResourcesService.allResourcesList().count
        pageControl.pageIndicatorTintColor = StyleManager.colors.lightGray
        pageControl.currentPageIndicatorTintColor = StyleManager.colors.darkGray
        pageControl.backgroundColor = StyleManager.colors.backgroundColor
        mainView.backgroundColor  = StyleManager.colors.backgroundColor
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func makeChildViewController(at index: Int?) -> UIViewController {
        let childVc: HomeResearchesChildController = UIStoryboard.home.instantiateViewController() as HomeResearchesChildController
        childVc.researchesDelegate = self
        childVc.index = index!
        return childVc
    }
}

//MARK: - PageboyViewControllerDataSource, PageboyViewControllerDelegate
extension HomeResearchesController: PageboyViewControllerDataSource, PageboyViewControllerDelegate {
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: PageboyViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        pageControl.currentPage = Int(index)
    }
   
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        let count = viewControllers.count
        return count
    }
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    //Unused Delegates
    func pageboyViewController(_ pageboyViewController: PageboyViewController, willScrollToPageAt index: PageboyViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollTo position: CGPoint, direction: PageboyViewController.NavigationDirection, animated: Bool) {
    }
    
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didReloadWith currentViewController: UIViewController, currentPageIndex: PageboyViewController.PageIndex) {
        
    }
}

extension HomeResearchesController: NavigateDelegate {
    
    func navigateResearchPage() {
        
    }
    
    func navigateMentorPage() {}
}


