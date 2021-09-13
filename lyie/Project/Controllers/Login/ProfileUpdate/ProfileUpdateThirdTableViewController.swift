//
//  ProfileUpdateThirdTableViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.11.2020.
//

import UIKit
import PopupDialog

class ProfileUpdateThirdTableViewController: UIViewController {

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
        
        logoView.backgroundColor = StyleManager.colors.white
        logoIcon.image = UIImage(named: "Dashboard/inovatim")
        logoView.makeShadow()
        shadowView.makeShadow()
        logoView.topBottomMakeShadow()
//        leftBarButtonIcon.image = UIImage(named: "Icons/left")
        
        self.tabBarController?.tabBar.backgroundColor = StyleManager.colors.white
        self.tabBarController?.tabBar.tintColor = StyleManager.colors.leftTitleColor
        myTableView.backgroundColor = StyleManager.colors.backgroundColor
        mainView.backgroundColor = StyleManager.colors.backgroundColor
        
//        mainView.backgroundColor = StyleManager.colors.white
//        myTableView.backgroundColor = StyleManager.colors.white
        
//        myTableView.register(UINib(nibName: InovatimLogoCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: InovatimLogoCell.reuseIdentifier)
        myTableView.register(UINib(nibName: IdentifierStepCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: IdentifierStepCell.reuseIdentifier)
        myTableView.register(UINib(nibName: KargaKargaCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: KargaKargaCell.reuseIdentifier)
        myTableView.register(UINib(nibName: NavigateButtonCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: NavigateButtonCell.reuseIdentifier)
    }
    
    func navigateAppStore() {
        var urlString = "https://apps.apple.com/us/app/karga-karga/id1500357354"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: urlString) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                if UIApplication.shared.canOpenURL(url as URL) {
                    UIApplication.shared.openURL(url as URL)
                }
            }
        }
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) {
            userItem.navigateKargaKarga = true
            UserProvider.update(users: userItem)
        }
    }
    
    @IBAction func tappedContinueButton(_ sender: Any) {
        let controller: DashboardController = UIStoryboard.dashboard.instantiateViewController()
        self.navigationController?.pushViewController(controller, animated: true)
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

extension ProfileUpdateThirdTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
//        case 0:
//            let cell: InovatimLogoCell = tableView.dequeueReusableCell(at: indexPath)
//            cell.selectionStyle = .none
//            return cell
        case 0:
            let cell: IdentifierStepCell = tableView.dequeueReusableCell(at: indexPath)
            cell.thirdStepConfig()
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell: KargaKargaCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config()
            cell.selectionStyle = .none
            cell.navigateKargaTapAction = { cell in
                if let user = UserDefaults.standard.string(forKey: currentUserKey), let userItem = UserProvider.users(for: user) {
                    if !userItem.navigateKargaKarga {
                        self.navigateAppStore()
                    } else {
                        self.errorWarning(titleText: "Uyarı", des: "Özgelecek değerlendirme formunuz doldurulmuştur.")
                    }
                }
                LyieLog.mPrint("Karga Karga")
            }
            return cell
        case 3:
            let cell: NavigateButtonCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config(PageStep: .third)
            cell.selectionStyle = .none
            cell.navigateTapAction = { cell in
                let controller: DashboardController = UIStoryboard.dashboard.instantiateViewController()
                self.navigationController?.pushViewController(controller, animated: true)
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
//        case 0:
//            return 90.0
        case 0:
            return 320.0
        case 1:
            return 480.0
        case 2:
            return 120.0
        default:
            return 120.0
        }
    }
}
// MARK: - AlertPopupViewDelegate
extension ProfileUpdateThirdTableViewController: AlertPopupViewDelegate {
    func closeTapped() {
        popup?.dismiss()
    }
    
    func alertAccept() {
        popup?.dismiss()
    }
    
    func alertCancel() {
        popup?.dismiss()
    }
    
    func firstTapped() {
    }
    
    func secondTapped() {
    }
    
    func thirdTapped() {
    }
    
    func errorWarning(titleText: String, des: String) {
        self.UI {
            AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: titleText, desc: des, vc: self)
        }
    }
}
