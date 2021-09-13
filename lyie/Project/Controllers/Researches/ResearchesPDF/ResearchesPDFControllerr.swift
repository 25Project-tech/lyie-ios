//
//  ResearchesPDFControllerr.swift
//  lyie
//
//  Created by Sevcan Eşim on 17.04.2021.
//

import UIKit
import WebKit
import Pageboy

class ResearchesPDFControllerr: PageboyViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var leftBarButtonIcon: UIImageView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    var pdfPageIndex = 0
    var pdfIndex = 0
        
    lazy var viewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        for i in 0 ..< pdfPageIndex {
            viewControllers.append(makeChildViewController(at: i))
        }
        return viewControllers
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        logoView.backgroundColor = StyleManager.colors.white
        logoIcon.image = UIImage(named: "Dashboard/inovatim")
        logoView.makeShadow()
        shadowView.makeShadow()
        logoView.topBottomMakeShadow()
        mainView.backgroundColor = StyleManager.colors.backgroundColor
        
        pageControl.backgroundColor = StyleManager.colors.backgroundColor
        pageControl.numberOfPages = pdfPageIndex
        pageControl.pageIndicatorTintColor = StyleManager.colors.lightGray
        pageControl.currentPageIndicatorTintColor = StyleManager.colors.darkGray
        
        self.tabBarController?.tabBar.backgroundColor = StyleManager.colors.white
        self.tabBarController?.tabBar.tintColor = StyleManager.colors.leftTitleColor
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func makeChildViewController(at index: Int?) -> UIViewController {
        let childVc: ResearchesChildControllerr = UIStoryboard.researches.instantiateViewController() as ResearchesChildControllerr
        childVc.index = index!
        childVc.pdfIndex = pdfIndex
        return childVc
    }
    
    @IBAction func tappedLeftBarButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedRightButton(_ sender: Any) {
        LyieUtils.configureLogOutActionSheet(view: self)
    }

}

//MARK: - PageboyViewControllerDataSource, PageboyViewControllerDelegate
extension ResearchesPDFControllerr: PageboyViewControllerDataSource, PageboyViewControllerDelegate {
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




