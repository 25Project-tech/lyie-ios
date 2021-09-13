//
//  ResearchesOnboardViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.02.2021.
//

import UIKit
import Pageboy

final class ResearchesOnboardViewController: PageboyViewController {
    
    @IBOutlet private weak var pageControl: UIPageControl!
    
    lazy var viewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        for i in 0 ..< 6 {
            viewControllers.append(makeChildViewController(at: i))
        }
        return viewControllers
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configRightBarButton()
        self.dataSource = self
        self.delegate = self
        pageControl.numberOfPages = 6
        pageControl.pageIndicatorTintColor = StyleManager.colors.lightGray
        pageControl.currentPageIndicatorTintColor = StyleManager.colors.darkGray
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = nil
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    ///Configs right bar button as skip/finish functionality
    func configRightBarButton() {
        let barButtonTitle: String = "Atla"
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: barButtonTitle, style: .done, target: self, action: #selector(self.onFinishButtonTap))
    }
    
    ///If navigation stack is empty pop else previous stage
    @objc func onFinishButtonTap(sender: UIBarButtonItem) {
//        let controller: SmartLightDevicePageController = UIStoryboard.smartlight.instantiateViewController()
//        controller.smartLightDevicePageDelegate = self
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func makeChildViewController(at index: Int?) -> UIViewController {
        let storyboard = UIStoryboard(name: "Researches", bundle: .main)
        let childVc = storyboard.instantiateViewController(withIdentifier: "ResearchesOnboardingChildViewController") as! ResearchesOnboardingChildViewController
        childVc.index = index!
        return childVc
    }
}

//MARK: - PageboyViewControllerDataSource, PageboyViewControllerDelegate
extension ResearchesOnboardViewController: PageboyViewControllerDataSource, PageboyViewControllerDelegate {
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: PageboyViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        pageControl.currentPage = Int(index)
        if index == 3 {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Bitti", style: .done, target: self, action: #selector(self.onFinishButtonTap))
        }
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

