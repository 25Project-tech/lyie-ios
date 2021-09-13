//
//  ResearchesDraftPagerController.swift
//  lyie
//
//  Created by Sevcan Eşim on 20.02.2021.
//

import Foundation
import UIKit
import Pageboy
import PopupDialog

enum ResearchType: String {
    case step1 = "1"
    case step2 = "2"
    case step3 = "3"
    case step4 = "4"
    case step5 = "5"
    case step6 = "6"
}

class ResearchesDraftPagerController: PageboyViewController {
    
    @IBOutlet weak var statusBarConstraint: NSLayoutConstraint!
    @IBOutlet var stepTitle: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var leftBarButtonIcon: UIImageView!
    @IBOutlet weak var rightBarButtonIcon: UIImageView!
    
    lazy var viewControllers = [ResearchesBaseController]()
    var researchesStepIndex = 0
    var popup: PopupDialog?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detay"
        dataSource = self
        delegate = self
        isScrollEnabled = false
        self.transition = Transition(style: .push, duration: 0.5)
    }
    
    @IBAction func tappedLeftBarButton(_ sender: Any) {
        if currentIndex! > 0 {
            self.scrollToPage(.previous, animated: true)
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func tappedRightButton(_ sender: Any) {
        LyieUtils.configureLogOutActionSheet(view: self)
    }
    
    
    @IBAction func tappedReadResearch(_ sender: Any) {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var researchItem = ResearchProvider.researchs(for: user) {
            let customVC: DraftResearchViewController = UIStoryboard.researches.instantiateViewController()
            customVC.popupsDraftResearchViewControllerDelegate = self as? PopupsDraftResearchViewControllerDelegate
            popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true, panGestureDismissal: false)
            self.present(popup!, animated: true, completion: nil)
        } else {
            self.errorWarning(titleText: "Hata", des: "Taslak araştırmanız mevcut değil")
        }
        
    }
    
    func errorWarning(titleText: String, des: String) {
        self.UI {
            AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: titleText, desc: des, vc: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
        configureTopBar(index: 0)
        navigationItem.leftBarButtonItem = nil
        stepTitle.text = "Step1"
        config()
    }
    
    func configureResearchDraft(with researchStepList: [ResearchType]) {
        for researchStep in researchStepList {
            viewControllers.append(loadChildViewController(with: researchStep))
        }
        researchesStepIndex = researchStepList.count
    }
    
    ///Configure The Topbar on Pageboy
    func configureTopBar(index: Int) {
        if researchesStepIndex == 6 {
            switch index {
            case 0:
                statusBarConstraint.constant = 333
            case 1:
                statusBarConstraint.constant = 266
            case 2:
                statusBarConstraint.constant = 200
            case 3:
                statusBarConstraint.constant = 133
            case 4:
                statusBarConstraint.constant = 66
            case 5:
                statusBarConstraint.constant = 0
            default:
                print("default")
            }
        } else if researchesStepIndex == 5 {
            switch index {
            case 0:
                statusBarConstraint.constant = 320
            case 1:
                statusBarConstraint.constant = 240
            case 2:
                statusBarConstraint.constant = 160
            case 3:
                statusBarConstraint.constant = 80
            case 4:
                statusBarConstraint.constant = 0
            default:
                print("default")
            }
        } else if researchesStepIndex == 4 {
            switch index {
            case 0:
                statusBarConstraint.constant = 300
            case 1:
                statusBarConstraint.constant = 200
            case 2:
                statusBarConstraint.constant = 100
            case 3:
                statusBarConstraint.constant = 0
            default:
                print("default")
            }
        } else if researchesStepIndex == 3 {
            switch index {
            case 0:
                statusBarConstraint.constant = 266
            case 1:
                statusBarConstraint.constant = 133
            case 2:
                statusBarConstraint.constant = 0
            default:
                print("default")
            }
        } else if researchesStepIndex == 2 {
            switch index {
            case 0:
                statusBarConstraint.constant = 200
            case 1:
                statusBarConstraint.constant = 0
            default:
                print("default")
            }
        } else {
            statusBarConstraint.constant = 0
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func loadChildViewController(with researchStep: ResearchType) -> ResearchesBaseController {
        let storyboard = UIStoryboard(name: "Researches", bundle: .main)
        switch researchStep {
        case .step1:
            let vc =  storyboard.instantiateViewController(withIdentifier: "ResearchesDraftFirstStepController") as! ResearchesDraftFirstStepController
            vc.newInstance(registerWizardListenerForProfileUpdate: self)
            return vc
        case .step2:
            let vc = storyboard.instantiateViewController(withIdentifier: "ResearchesDraftSecondStepController") as! ResearchesDraftSecondStepController
            vc.newInstance(registerWizardListenerForProfileUpdate: self)
            return vc
        case .step3:
            let vc = storyboard.instantiateViewController(withIdentifier: "ResearchesDraftThirdStepController") as! ResearchesDraftThirdStepController
            vc.newInstance(registerWizardListenerForProfileUpdate: self)
            return vc
        case .step4:
            let vc = storyboard.instantiateViewController(withIdentifier: "ResearchesDraftFourthStepController") as! ResearchesDraftFourthStepController
            vc.newInstance(registerWizardListenerForProfileUpdate: self)
            return vc
        case .step5:
            let vc = storyboard.instantiateViewController(withIdentifier: "ResearchesDraftFifthStepController") as! ResearchesDraftFifthStepController
            vc.newInstance(registerWizardListenerForProfileUpdate: self)
            return vc
        case .step6:
            let vc = storyboard.instantiateViewController(withIdentifier: "ResearchesDraftSixthStepController") as! ResearchesDraftSixthStepController
            vc.newInstance(registerWizardListenerForProfileUpdate: self)
            return vc
        default:
            return storyboard.instantiateViewController(withIdentifier: "ResearchesDraftFirstStepController") as! ResearchesDraftFirstStepController
        }
    }
    
    func config() {
        if logoView != nil && logoIcon != nil && shadowView != nil && leftBarButtonIcon != nil {
            logoView.backgroundColor = StyleManager.colors.white
            logoIcon.image = UIImage(named: "Dashboard/inovatim")
            logoView.makeShadow()
            shadowView.makeShadow()
            logoView.topBottomMakeShadow()
//            leftBarButtonIcon.image = UIImage(named: "arrow")
            leftBarButtonIcon.tintColor = StyleManager.colors.leftTitleColor
        }
    }
}

//MARK: - PageboyViewControllerDataSource,PageboyViewControllerDelegate
extension ResearchesDraftPagerController: PageboyViewControllerDataSource,PageboyViewControllerDelegate {
    func pageboyViewController(_ pageboyViewController: PageboyViewController, willScrollToPageAt index: PageboyViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        configureTopBar(index: index)
        if index > 0 {
            if index == 1 {
                stepTitle.text = "Step2"
            } else if index == 2 {
                stepTitle.text = "Step3"
            } else if index == 3 {
                stepTitle.text = "Step4"
            } else if index == 4 {
                stepTitle.text = "Step5"
            } else {
                stepTitle.text = "Step6"
            }
        } else {
            navigationItem.leftBarButtonItem = nil
            stepTitle.text = "Step1"
        }
             
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollTo position: CGPoint, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: PageboyViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didReloadWith currentViewController: UIViewController, currentPageIndex: PageboyViewController.PageIndex) {
        
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        let count = viewControllers.count
        return count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

//MARK: - RegisterWizardListener
extension ResearchesDraftPagerController: RegisterWizardListenerForProfileUpdate {
    
    ///Go To Previous Stage On Pager
    func onPreviousStage() {
        self.scrollToPage(.previous, animated: true)
    }
    
    ///Go To Next Stage On Pager
    func onNextStage() {
        self.scrollToPage(.next, animated: true)
    }
    
    ///Dismiss The ProfileUpdate
    func onDismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
