//
//  ProfileUpdateSecondTableViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.11.2020.
//

import UIKit
import PopupDialog
import Parse

class ProfileUpdateSecondTableViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var leftBarButtonIcon: UIImageView!
    @IBOutlet weak var rightBarButtonIcon: UIImageView!
    
    var popup: PopupDialog?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LyieUtils.profileProgressUpdate {}
        logoView.backgroundColor = StyleManager.colors.white
        logoIcon.image = UIImage(named: "Dashboard/inovatim")
        logoView.makeShadow()
        shadowView.makeShadow()
        logoView.topBottomMakeShadow()
        
        self.tabBarController?.tabBar.backgroundColor = StyleManager.colors.white
        self.tabBarController?.tabBar.tintColor = StyleManager.colors.leftTitleColor
        myTableView.backgroundColor = StyleManager.colors.backgroundColor
        mainView.backgroundColor = StyleManager.colors.backgroundColor

        myTableView.register(UINib(nibName: IdentifierStepCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: IdentifierStepCell.reuseIdentifier)
        myTableView.register(UINib(nibName: Education101Cell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: Education101Cell.reuseIdentifier)
        myTableView.register(UINib(nibName: Education101Cell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: Education101Cell.reuseIdentifier)
        myTableView.register(UINib(nibName: Education101Cell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: Education101Cell.reuseIdentifier)
        myTableView.register(UINib(nibName: NavigateButtonCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: NavigateButtonCell.reuseIdentifier)
    }
    
    @IBAction func tappedContinueButton(_ sender: Any) {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            if studentEducationItem.education101aiNum != 0 && studentEducationItem.education101inoNum != 0 && studentEducationItem.education101iotNum != 0 {
                let controller: ProfileUpdateThirdTableViewController = UIStoryboard.loginRegister.instantiateViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                self.errorWarning(titleText: "Hata", des: "Alanlar boş bırakılamaz.")
            }
        }
    }
    
    @IBAction func tappedBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedLeftBarButton(_ sender: Any) {
        
    }
    
    @IBAction func tappedRightButton(_ sender: Any) {
        LyieUtils.configureLogOutActionSheet(view: self)
    }
    
}

extension ProfileUpdateSecondTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: IdentifierStepCell = tableView.dequeueReusableCell(at: indexPath)
            cell.secondStepConfig()
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell: Education101Cell = tableView.dequeueReusableCell(at: indexPath)
            cell.config(Education: .inovation, inoHidden: false, iotHidden: false, aiHidden: false, numberViewHidden: false, lockScreen: false, isProfileUpdate: true, isMentorUpdate: false)
            cell.navigateNumberTapAction = { cell in
                if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                    if studentEducationItem.education101inoNum != 1 {
                        self.selectedWarning(first: false, second: false, third: false, typeNo: 1)
                    }
                }
            }
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell: Education101Cell = tableView.dequeueReusableCell(at: indexPath)
            cell.config(Education: .iot, inoHidden: false, iotHidden: false, aiHidden: false, numberViewHidden: false, lockScreen: false, isProfileUpdate: true, isMentorUpdate: false)
            cell.navigateNumberTapAction = { cell in
                self.selectedWarning(first: false, second: false, third: false, typeNo: 2)
            }
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell: Education101Cell = tableView.dequeueReusableCell(at: indexPath)
            cell.config(Education: .ai, inoHidden: false, iotHidden: false, aiHidden: true, numberViewHidden: false, lockScreen: false, isProfileUpdate: true, isMentorUpdate: false)
            cell.navigateNumberTapAction = { cell in
                self.selectedWarning(first: false, second: false, third: false, typeNo: 3)
            }
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell: NavigateButtonCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config(PageStep: .second)
            cell.selectionStyle = .none
            cell.navigateTapAction = { cell in
                if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                    if studentEducationItem.education101aiNum != 0 && studentEducationItem.education101inoNum != 0 && studentEducationItem.education101iotNum != 0 {
//                        let controller: ProfileUpdateThirdTableViewController = UIStoryboard.loginRegister.instantiateViewController()
//                        self.navigationController?.pushViewController(controller, animated: true)
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        let controller: DashboardController = UIStoryboard.dashboard.instantiateViewController()
                        self.navigationController?.pushViewController(controller, animated: true)
                    } else {
                        self.errorWarning(titleText: "Hata", des: "Alanlar boş bırakılamaz.")
                    }
                }
            }
            cell.navigateBackTapAction = { cell in
                self.navigationController?.popViewController(animated: true)
            }
            return cell
        default:
            let cell: InovatimLogoCell = tableView.dequeueReusableCell(at: indexPath)
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 365.0
        case 1:
            return 650.0
        case 2:
            return 650.0
        case 3:
            return 650.0
        case 4:
            return 120.0
        default:
            return 120.0
        }
    }
}

// MARK: - AlertPopupViewDelegate
extension ProfileUpdateSecondTableViewController: AlertPopupViewDelegate {
    func closeTapped() {
        popup?.dismiss()
        self.myTableView.reloadData()
    }
    
    func alertAccept() {
        popup?.dismiss()
        self.myTableView.reloadData()
    }
    
    func alertCancel() {
        LyieUtils.cancelInfoUserEducationProgress()
        popup?.dismiss()
        self.myTableView.reloadData()
    }
    
    func firstTapped() {
        popup?.dismiss()
        self.myTableView.reloadData()
    }
    
    func secondTapped() {
        popup?.dismiss()
        self.myTableView.reloadData()
    }
    
    func thirdTapped() {
        popup?.dismiss()
        self.myTableView.reloadData()
    }
    
    func showNotifySelectAlert(animated: Bool = true, customAlert: AlertPopupView, isCancelHidden: Bool, isAcceptHidden: Bool, type: Int) {
        let customVC = PopupSortingAlertViewController()
        customVC.delegate = self
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        customVC.educationType = type
        customVC.config(alert: customAlert)
        customVC.cancelBtn.isHidden = isCancelHidden
        customVC.acceptBtn.isHidden = isAcceptHidden
        self.present(popup!, animated: animated, completion: nil)
    }
    
    func selectedWarning(first: Bool, second: Bool, third: Bool, typeNo: Int) {
        self.UI {
            let customAlert = AlertPopupView(
                title: "",
                description: "",
                alertIcon: UIImage(named: "Settings/warning10")!,
                cancelBtnTitle: "Sıfırla",
                acceptBtnTitel: "Tamamla",
                cancelBtnBackColor: StyleManager.colors.leftTitleColor,
                acceptBtnBackColor: StyleManager.colors.leftTitleColor,
                alertBackViewColor: StyleManager.colors.white)
            self.showNotifySelectAlert(customAlert: customAlert, isCancelHidden: false, isAcceptHidden: false, type: typeNo)
        }
    }
    
    func errorWarning(titleText: String, des: String) {
        self.UI {
            AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: titleText, desc: des, vc: self)
        }
    }
}
