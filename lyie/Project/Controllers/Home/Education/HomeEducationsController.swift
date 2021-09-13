//
//  HomeEducationsController.swift
//  lyie
//
//  Created by Sevcan Eşim on 29.11.2020.
//

import UIKit
import Pageboy

final class HomeEducationsController: PageboyViewController {
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet private weak var pageControl: UIPageControl!
    lazy var viewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        for i in 0 ..< 3 {
            viewControllers.append(makeChildViewController(at: i))
        }
        return viewControllers
    }()

    var popupDelegate: PopupDelegate!
    var isMentor = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        pageControl.backgroundColor = StyleManager.colors.backgroundColor
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = StyleManager.colors.lightGray
        pageControl.currentPageIndicatorTintColor = StyleManager.colors.darkGray
        mainView.backgroundColor = StyleManager.colors.backgroundColor
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func makeChildViewController(at index: Int?) -> UIViewController {
        let childVc: HomeEducationsChildController = UIStoryboard.home.instantiateViewController() as HomeEducationsChildController
        childVc.isMentor = isMentor
        childVc.alertDelegate = self
        childVc.index = index!
        return childVc
    }
}

//MARK: - PageboyViewControllerDataSource, PageboyViewControllerDelegate
extension HomeEducationsController: PageboyViewControllerDataSource, PageboyViewControllerDelegate {
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

extension HomeEducationsController: PopupDelegate {
    func alertView() {
        popupDelegate.alertView()
    }
}
