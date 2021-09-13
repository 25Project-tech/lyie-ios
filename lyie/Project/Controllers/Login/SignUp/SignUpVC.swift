//
//  SignUpVC.swift
//  lyie
//
//  Created by Sevcan Eşim on 6.05.2021.
//

import UIKit
import PopupDialog
import Parse
import KRProgressHUD

class SignUpVC: UIViewController, NewUserObserver {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var leftBarButtonIcon: UIImageView!
    @IBOutlet weak var rightBarButtonIcon: UIImageView!
    
    var popup: PopupDialog?
    var userPass = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startObservingNewUsers()
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
        myTableView.register(UINib(nibName: SignUpUserInfo.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: SignUpUserInfo.reuseIdentifier)
        myTableView.register(UINib(nibName: SignUpButtonCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: SignUpButtonCell.reuseIdentifier)
    }
    
    deinit {
        stopObservingNewUsers()
    }
    
    @IBAction func tappedContinueButton(_ sender: Any) {

    }
    
    @IBAction func tappedLeftBarButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedRightButton(_ sender: Any) {
        LyieUtils.configureLogOutActionSheet(view: self)
    }
    
    func onDidChange(users: [NewUserItem]) {
        myTableView.reloadData()
    }
}

extension SignUpVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: IdentifierStepCell = tableView.dequeueReusableCell(at: indexPath)
            cell.firstStepConfig()
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell: SignUpUserInfo = tableView.dequeueReusableCell(at: indexPath)
            cell.config()
            cell.selectionStyle = .none
            
            //NAME-SURNAME
            cell.navigateNameSurnameTapAction = { cell in
                self.showNewTV(type: 1)
            }
            
            //City
            cell.navigateUserCityTapAction = { cell in
                self.showSearch(type: 3)
            }
            
            //Kullanıcı  Adı
            cell.navigateUserIDTapAction = { cell in
                self.showNewTV(type: 5)
            }
            //PHONE
            cell.navigatePhoneTapAction = { cell in
                self.showNewTV(type: 3)
            }
            
            //MAIL
            cell.navigateMailTapAction = { cell in
                self.showNewTV(type: 4)
            }
            
            cell.navigatePasswordTapAction = { cell in
                self.showNewTV(type: 2)
            }
            
            cell.navigateKVKKTapAction = { cell in
                self.UI {
                    AlertModelAPI.kvkkAlert(imageString: "Settings/complete", title: "Gizlilik Sözleşmesi", desc: "", vc: self)
                }
            }
            
            return cell
            
        case 2:
            let cell: SignUpButtonCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config()
            cell.selectionStyle = .none
            cell.navigateSaveAction = { cell in
                guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
                    return
                }
                if newUserItem.approvedKVKK != true {
                    self.errorWarning(titleText: "Hata", des: "Gizlilik Sözleşmesi onaylanmadı.")
                } else {
                    newUserItem.userType = "User"
                    NewUserProvider.update(users: newUserItem)
                    
                    newUserItem.FirstMentor = "Dijital Mentor"
                    newUserItem.SecondMentor = "Dijital Mentor"
                    
                    self.UI {
                        LyieUtils.uploadUserInfo(view: self) {
                            if newUserItem.userID != "adminMentor" {
                                self.performAction()
                            }
                        }
                    }
                }
            }
            
            cell.navigateDeleteAction = { cell in
                if let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) {
                    NewUserProvider.remove(users: newUserItem)
                    newUserItem = NewUserProvider.create(with: user)
                    newUserItem.userType = "User" //0
                    newUserItem.name = ""  //1
                    newUserItem.password = "" //2
                    newUserItem.phone = "" //3
                    newUserItem.mail = "" //4
                    newUserItem.userID = "" //5
                    newUserItem.classID = "" //6
                    newUserItem.highSchoolName = "" //7
                    newUserItem.University = "" //8
                    newUserItem.Department = "" //9
                    newUserItem.FirstMentor = ""  //10
                    newUserItem.SecondMentor = ""  //11
                    newUserItem.FirstClass = ""  //12
                    newUserItem.SecondClass = "" //13
                    NewUserProvider.update(users: newUserItem)
                    PFUser.enableRevocableSessionInBackground()
                }
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
            return 335.0
        case 2:
            return 120.0
        default:
            return 120.0
        }
    }
}

extension SignUpVC: TVNewUserDelegate {
    func onNewDismissed() {
        UI {
            self.popup?.dismiss()
        }
    }
    
    func onChangeText(userTypeN: String) {}
    
    func onChangeText(nameN: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        newUserItem.name = nameN
        NewUserProvider.update(users: newUserItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(passN: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        newUserItem.password = passN
        NewUserProvider.update(users: newUserItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(mailN: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        newUserItem.mail = mailN
        NewUserProvider.update(users: newUserItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(phoneN: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        newUserItem.phone = phoneN
        NewUserProvider.update(users: newUserItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(userIDN: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        newUserItem.userID = userIDN
        NewUserProvider.update(users: newUserItem)
        LyieUtils.checkUserName(view: self)
        self.myTableView.reloadData()
    }
    
    func onChangeText(classIDN: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        newUserItem.classID = classIDN
        NewUserProvider.update(users: newUserItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(UniversityN: String) {}
    
    func onChangeText(FirstClassN: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        newUserItem.FirstClass = FirstClassN
        NewUserProvider.update(users: newUserItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(FirstMentorN: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        newUserItem.FirstMentor = FirstMentorN
        NewUserProvider.update(users: newUserItem)
        LyieUtils.getMentorClass(userName: FirstMentorN)
        
        self.myTableView.reloadData()
    }
    
    func onChangeText(SecondClassN: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        newUserItem.SecondClass = SecondClassN
        NewUserProvider.update(users: newUserItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(SecondMentorN: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        newUserItem.SecondMentor = SecondMentorN
        NewUserProvider.update(users: newUserItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(highSchoolNameN: String) {}
    
    func onChangeText(DepartmentN: String) {}
}

extension SignUpVC {
    
    func showStringPicker(animated: Bool = true, pickerType: Int) { //CASE 2
        let customVC = StringPickerViewController(nibName: "StringPickerViewController", bundle: nil)
        customVC.userInfoPickerDelegate = self
        customVC.pickerType = pickerType
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
    
    func showSearch(animated: Bool = true, type: Int) { //CASE 2
        let customVC = SearchViewController(nibName: "SearchViewController", bundle: nil)
        customVC.searchDelegate = self
        customVC.searchType = type
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
    
    func showNewTV(animated: Bool = true, type: Int) {
        let customVC = TVNewUserPopup(nibName: "TVNewUserPopup", bundle: nil)
        customVC.tvDelegate = self
        customVC.textViewType = type
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
}

//MARK: - USERINFOPICKER DELEGATE
extension SignUpVC: UserInfoPickerDelegate {
    func onGenderSet(gender: String) {}

    func onAgeSet(date: Date) {}

    func onClassSet(classNumber: String) {}
    
    func onDepartmentSet(departmentName: String) {}
    
    func onTypeSet(type: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        newUserItem.userType = type
        NewUserProvider.update(users: newUserItem)
        self.myTableView.reloadData()
    }
    
    func onPickerDismissed() {
        DispatchQueue.main.async {
            self.popup?.dismiss()
        }
    }
}

extension SignUpVC: SearchDelegate {
    func onChangeText(targetUniName: String) {}
    func onChangeText(targetDeptName: String) {}
    func onChangeText(hSchoolName: String) {}
    
    func onCitySet(city: Int) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        newUserItem.city = city
        NewUserProvider.update(users: newUserItem)
        self.myTableView.reloadData()
    }
    func onPlaceOfBirthSet(city: Int) {}
    
    func onChangeText(hSchoolDept: String) {}
    
    func onChangeText(newUserHG: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        newUserItem.highSchoolName = newUserHG
        NewUserProvider.update(users: newUserItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(newUserUni: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        newUserItem.University = newUserUni
        NewUserProvider.update(users: newUserItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(newUserDept: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        newUserItem.Department = newUserDept
        NewUserProvider.update(users: newUserItem)
        self.myTableView.reloadData()
    }
    
    
    func onDismissed() {
        UI {
            self.popup?.dismiss()
        }
    }
}

// MARK: - AlertPopupViewDelegate
extension SignUpVC: AlertPopupViewDelegate {
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
    
    func performAction() {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) {
            PFUser.logInWithUsername(inBackground: newUserItem.userID, password: newUserItem.password) { (user, error) in
                if user != nil {
                    KRProgressHUD.dismiss {
                        print("Login")
                        if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey) {
                            if var userItem = UserProvider.users(for: currentUserInfo) {
                                userItem.userType = newUserItem.userType
                                userItem.userID = newUserItem.userID
                                userItem.password = newUserItem.password
                                UserProvider.update(users: userItem)
                            }
                        }
                        if let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) {
                            let controller: ProfileUpdateTableViewController = UIStoryboard.loginRegister.instantiateViewController()
                            controller.userPass = newUserItem.password
                            self.navigationController?.pushViewController(controller, animated: true)
                        }
                    }
                }
            }
        }
        
    }
}

