//
//  ProfileUpdateTableViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.11.2020.
//

import UIKit
import PopupDialog
import Parse

class ProfileUpdateTableViewController: UIViewController, UserObserver, NewUserObserver {

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
        startObservingUsers()
        
        logoView.backgroundColor = StyleManager.colors.white
        logoIcon.image = UIImage(named: "Dashboard/inovatim")
        logoView.makeShadow()
        shadowView.makeShadow()
        logoView.topBottomMakeShadow()
        LyieUtils.homeMentorCardUpdate {
            LyieUtils.profileProgressUpdate {
                
            }
        }
        self.tabBarController?.tabBar.backgroundColor = StyleManager.colors.white
        self.tabBarController?.tabBar.tintColor = StyleManager.colors.leftTitleColor
        myTableView.backgroundColor = StyleManager.colors.backgroundColor
        mainView.backgroundColor = StyleManager.colors.backgroundColor
        
        myTableView.register(UINib(nibName: IdentifierStepCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: IdentifierStepCell.reuseIdentifier)
        myTableView.register(UINib(nibName: PersonalInfoCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: PersonalInfoCell.reuseIdentifier)
        myTableView.register(UINib(nibName: EducationInfoCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: EducationInfoCell.reuseIdentifier)
        myTableView.register(UINib(nibName: EducationInfoMentorCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: EducationInfoMentorCell.reuseIdentifier)
        myTableView.register(UINib(nibName: NavigateButtonCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NavigateButtonCell.reuseIdentifier)
        
        loadDataWithParse()
    }
    
    deinit {
        stopObservingUsers()
        stopObservingNewUsers()
    }
    
    @IBAction func tappedContinueButton(_ sender: Any) {
        firstCheck()
    }
    
    @IBAction func tappedLeftBarButton(_ sender: Any) {
        
    }
    
    @IBAction func tappedRightButton(_ sender: Any) {
        
    }
    
    func onDidChange(users: [UserItem]) {
        myTableView.reloadData()
    }
    
    func onDidChange(users: [NewUserItem]) {
        myTableView.reloadData()
    }
}

extension ProfileUpdateTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: IdentifierStepCell = tableView.dequeueReusableCell(at: indexPath)
            cell.firstStepConfig()
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell: PersonalInfoCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config()
            cell.selectionStyle = .none
            
            //TARGET
            cell.navigateTargetTapAction = { cell in
                self.showTV(type: 0)
            }
            
            //NAME-SURNAME
            cell.navigateNameSurnameTapAction = { cell in
                self.showTF(type: 0)
            }
            
            //DATE OF BIRTH
            cell.navigateDateOfBirthTapAction = { cell in
                self.showAge()
            }
            
            //PLACE OF BIRTH
            cell.navigatePlaceOfBirthTapAction = { cell in
                self.showSearch(type: 4)
            }
            
            //GENDER
            cell.navigateGenderTapAction = { cell in
                self.showStringPicker(pickerType: 0)
            }
            
            //CITY
            cell.navigateCityTapAction = { cell in
                self.showSearch(type: 3)
            }
            
            //PHONE
            cell.navigatePhoneTapAction = { cell in
                self.showTF(type: 3)
            }
            
            //MAIL
            cell.navigateMailTapAction = { cell in
                self.showTF(type: 2)
            }
            
            return cell
            
        case 2:
            if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey) {
                if let userItem = UserProvider.users(for: currentUserInfo) {
                    if userItem.userType == "Mentor" {
                        let cell: EducationInfoMentorCell = tableView.dequeueReusableCell(at: indexPath)
                        cell.config()
                        //Target University
                        cell.navigateTargetUniversityTapAction = { cell in
                            self.showSearch(type: 0)
                        }
                        
                        //Target Department
                        cell.navigateTargetDepartmentTapAction = { cell in
                            self.showSearch(type: 1)
                        }
                        
                        cell.navigateKVKKTapAction = { cell in
                            self.UI {
                                AlertModelAPI.kvkkAlert(imageString: "Settings/complete", title: "Gizlilik Sözleşmesi", desc: "", vc: self)
                            }
                        }
                        
                        cell.selectionStyle = .none
                        return cell
                    } else {
                        let cell: EducationInfoCell = tableView.dequeueReusableCell(at: indexPath)
                        cell.config()
                        
                        //HS
                        cell.navigateHSTapAction = { cell in
                            self.showSearch(type: 2)
                        }
                        
                        //Class
                        cell.navigateClassTapAction = { cell in
                            self.showStringPicker(pickerType: 1)
                        }
                        
                        //Department
                        cell.navigateDepartmentTapAction = { cell in
                            self.showSearch(type: 8)
                        }
                        
                        //Target University
                        cell.navigateTargetUniversityTapAction = { cell in
                            self.showSearch(type: 0)
                        }
                        
                        //Target Department
                        cell.navigateTargetDepartmentTapAction = { cell in
                            self.showSearch(type: 1)
                        }
                        
                        cell.navigateKVKKTapAction = { cell in
                            self.UI {
                                AlertModelAPI.kvkkAlert(imageString: "Settings/complete", title: "Gizlilik Sözleşmesi", desc: "", vc: self)
                            }
                        }
                        
                        cell.selectionStyle = .none
                        return cell
                    }
                } else {
                    let cell: EducationInfoCell = tableView.dequeueReusableCell(at: indexPath)
                    cell.config()
                    
                    //HS
                    cell.navigateHSTapAction = { cell in
                        self.showSearch(type: 2)
                    }
                    
                    //Class
                    cell.navigateClassTapAction = { cell in
                        self.showStringPicker(pickerType: 1)
                    }
                    
                    //Department
                    cell.navigateDepartmentTapAction = { cell in
                        self.showSearch(type: 8)
                    }
                    
                    //Target University
                    cell.navigateTargetUniversityTapAction = { cell in
                        self.showSearch(type: 0)
                    }
                    
                    //Target Department
                    cell.navigateTargetDepartmentTapAction = { cell in
                        self.showSearch(type: 1)
                    }
                    
                    cell.navigateKVKKTapAction = { cell in
                        self.UI {
                            AlertModelAPI.kvkkAlert(imageString: "Settings/complete", title: "Gizlilik Sözleşmesi", desc: "", vc: self)
                        }
                    }
                    
                    cell.selectionStyle = .none
                    return cell
                }
            } else {
                let cell: EducationInfoCell = tableView.dequeueReusableCell(at: indexPath)
                cell.config()
                
                //HS
                cell.navigateHSTapAction = { cell in
                    self.showSearch(type: 2)
                }
                
                //Class
                cell.navigateClassTapAction = { cell in
                    self.showStringPicker(pickerType: 1)
                }
                
                //Department
                cell.navigateDepartmentTapAction = { cell in
                    self.showSearch(type: 8)
                }
                
                //Target University
                cell.navigateTargetUniversityTapAction = { cell in
                    self.showSearch(type: 0)
                }
                
                //Target Department
                cell.navigateTargetDepartmentTapAction = { cell in
                    self.showSearch(type: 1)
                }
                
                cell.navigateKVKKTapAction = { cell in
                    self.UI {
                        AlertModelAPI.kvkkAlert(imageString: "Settings/complete", title: "Gizlilik Sözleşmesi", desc: "", vc: self)
                    }
                }
                
                cell.selectionStyle = .none
                return cell
            }
            
        case 3:
            let cell: NavigateButtonCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config(PageStep: .first)
            cell.selectionStyle = .none
            cell.navigateTapAction = { cell in
                self.secondCheck()
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
            return 390.0
        case 2:
            if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey) {
                if let userItem = UserProvider.users(for: currentUserInfo) {
                    if userItem.userType == "Mentor" {
                        return 250.0
                    } else {
                        return 350.0
                    }
                } else {
                    return 350.0
                }
            } else {
                return 350.0
            }
        case 3:
            return 120.0
        default:
            return 120.0
        }
    }
}
extension ProfileUpdateTableViewController {
    
    func showStringPicker(animated: Bool = true, pickerType: Int) { //CASE 2
        let customVC = StringPickerViewController(nibName: "StringPickerViewController", bundle: nil)
        customVC.userInfoPickerDelegate = self
        customVC.pickerType = pickerType
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
    
    func showAge(animated: Bool = true) { //CASE 3
        let customVC = AgePickerViewController(nibName: "AgePickerViewController", bundle: nil)
        customVC.userInfoPickerDelegate = self
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
    
    func showCity(animated: Bool = true, placeOfBirth: Bool) { //CASE 2
        let customVC = CityPickerViewController(nibName: "CityPickerViewController", bundle: nil)
        customVC.userInfoPickerDelegate = self
        customVC.placeOfBirth = placeOfBirth
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
    
    func showTF(animated: Bool = true, type: Int) { //CASE 2
        let customVC = TFPopupAlertViewController(nibName: "TFPopupAlertViewController", bundle: nil)
        customVC.tfDelegate = self
        customVC.textFieldType = type
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
    
    func showTV(animated: Bool = true, type: Int) { //CASE 2
        let customVC = TVPopupAlertViewController(nibName: "TVPopupAlertViewController", bundle: nil)
        customVC.tvDelegate = self
        customVC.textViewType = type
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
}


//MARK: - TFDelegate DELEGATE
extension ProfileUpdateTableViewController: TFDelegate {
    func onChangeText(nameSurname: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else {
            return
        }
        userItem.name = nameSurname
        UserProvider.update(users: userItem)
        self.myTableView.reloadData()
    }

    func onChangeText(mail: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else {
            return
        }
        userItem.mail = mail
        UserProvider.update(users: userItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(phone: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else {
            return
        }
        userItem.phone = phone
        UserProvider.update(users: userItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(highSchollName: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else {
            return
        }
        studentInfoItem.highSchoolName = highSchollName
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(targetUni: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else {
            return
        }
        studentInfoItem.targetUniversity = targetUni
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        self.myTableView.reloadData()
    }
    

    func onChangeText(targetDept: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else {
            return
        }
        studentInfoItem.targetDepartment = targetDept
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        self.myTableView.reloadData()
    }
    
    func onTFDismissed() {
        popup?.dismiss()
    }
}

//MARK: - TVDelegate DELEGATE
extension ProfileUpdateTableViewController: TVDelegate {
    
    func onChangeText(target: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else {
            return
        }
        userItem.targetString = target
        UserProvider.update(users: userItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(ques: String) {}
    
    func onChangeText(ans: String) {}
    
    func onTVDismissed() {
        popup?.dismiss()
    }
}

extension ProfileUpdateTableViewController: SearchDelegate {
    func onChangeText(targetUniName: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else {
            return
        }
        studentInfoItem.targetUniversity = targetUniName
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(targetDeptName: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else {
            return
        }
        studentInfoItem.targetDepartment = targetDeptName
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(hSchoolName: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else {
            return
        }
        studentInfoItem.highSchoolName = hSchoolName
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        self.myTableView.reloadData()
    }
    
    func onCitySet(city: Int) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else {
            return
        }
        userItem.city = city
        UserProvider.update(users: userItem)
        self.myTableView.reloadData()
    }
    
    func onPlaceOfBirthSet(city: Int) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else {
            return
        }
        userItem.placeofBirth = city
        UserProvider.update(users: userItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(hSchoolDept: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else {
            return
        }
        studentInfoItem.departmentName = hSchoolDept
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        self.myTableView.reloadData()
    }
    
    func onChangeText(newUserUni: String) {}
    
    func onChangeText(newUserHG: String) {}
    
    func onChangeText(newUserDept: String) {}
    
    func onDismissed() {
        UI {
            self.popup?.dismiss()
        }
    }
}

//MARK: - USERINFOPICKER DELEGATE
extension ProfileUpdateTableViewController: UserInfoPickerDelegate {
    func onGenderSet(gender: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else { return }
        userItem.gender = gender
        UserProvider.update(users: userItem)
        self.myTableView.reloadData()
    }

    func onAgeSet(date: Date) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else {
            return
        }
        userItem.dateofBirth = date
        UserProvider.update(users: userItem)
        self.myTableView.reloadData()
    }

    func onClassSet(classNumber: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else { return }
        studentInfoItem.classNumber = classNumber
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        self.myTableView.reloadData()
    }
    
    func onDepartmentSet(departmentName: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else { return }
        studentInfoItem.departmentName = departmentName
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        self.myTableView.reloadData()
    }
    
    func onPickerDismissed() {
        DispatchQueue.main.async {
            self.popup?.dismiss()
        }
    }
}

// MARK: - AlertPopupViewDelegate
extension ProfileUpdateTableViewController: AlertPopupViewDelegate {
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

extension ProfileUpdateTableViewController {
    func loadDataWithParse() {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user), var studentInfoItem = StudentInfoProvider.studentInfos(for: user), var newUser = NewUserProvider.users(for: user) {
            if let currentUser = PFUser.current() {
                if currentUser["purpose"] != nil {
                    userItem.targetString = currentUser["purpose"] as! String
                }
                if currentUser["fullName"] != nil {
                    userItem.name = currentUser["fullName"] as! String
                }
                
                if currentUser["dateOfBirth"] != nil {
                    userItem.dateofBirth = currentUser["dateOfBirth"] as! Date
                }
                
                if currentUser["placeOfBirth"] != nil  {
                    userItem.placeofBirth = currentUser["placeOfBirth"] as! Int
                }
                
                if currentUser["gender"] != nil {
                    userItem.gender = currentUser["gender"] as! String
                }
                
                if currentUser["city"] != nil {
                    userItem.city = currentUser["city"] as! Int
                }
                
                if currentUser["phone"] != nil {
                    userItem.phone = currentUser["phone"] as! String
                }
                
                if currentUser["email"] != nil {
                    userItem.mail = currentUser["email"] as! String
                }
                
                if currentUser["approved"] != nil {
                    newUser.approvedKVKK = currentUser["approved"] as! Bool
                }
                
                UserProvider.update(users: userItem)
                NewUserProvider.update(users: newUser)
                
                let currentUserEducation = currentUser.relation(forKey: "userEducation")
                currentUserEducation.query().findObjectsInBackground { (objects, error) in
                    if let objects = objects {
                        if objects.count > 0 {
                            if objects.first != nil {
                                if objects.first?.object(forKey: "highSchoolName") != nil {
                                    studentInfoItem.highSchoolName = objects.first?.object(forKey: "highSchoolName") as! String
                                }
                                
                                if objects.first?.object(forKey: "highSClassNumber") != nil {
                                    studentInfoItem.classNumber = objects.first?.object(forKey: "highSClassNumber") as! String
                                }
                                
                                if objects.first?.object(forKey: "departmentName") != nil {
                                    studentInfoItem.departmentName = objects.first?.object(forKey: "departmentName") as! String
                                }
                                
                                if objects.first?.object(forKey: "targetUniversity") != nil {
                                    studentInfoItem.targetUniversity = objects.first?.object(forKey: "targetUniversity") as! String
                                }
                                
                                if objects.first?.object(forKey: "targetDepartment") != nil {
                                    studentInfoItem.targetDepartment = objects.first?.object(forKey: "targetDepartment") as! String
                                }
                                
                                StudentInfoProvider.update(studentInfos: studentInfoItem)
                                LyieUtils().createdRealmObjForEducation()
                                self.myTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func firstCheck() {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let userItem = UserProvider.users(for: user), let studentInfoItem = StudentInfoProvider.studentInfos(for: user), let newUser = NewUserProvider.users(for: user) {
            if userItem.userType == "Student" {
                if userItem.targetString != "" && userItem.name != "" && userItem.dateofBirth?.timeIntervalSince1970 != 0 && userItem.gender != ""  && userItem.phone != "" && userItem.mail != "" && studentInfoItem.highSchoolName != "" && studentInfoItem.classNumber != "" && studentInfoItem.departmentName != "" && studentInfoItem.targetUniversity != "" && studentInfoItem.targetDepartment != "" && newUser.approvedKVKK != false {
                    let controller: ProfileUpdateSecondTableViewController = UIStoryboard.loginRegister.instantiateViewController()
                    self.navigationController?.pushViewController(controller, animated: true)
                    if let currentUser = PFUser.current(), let currentUserName = currentUser.username {
                        LyieUtils.updateUser(target: userItem.targetString, fullName: userItem.name, birthDay: userItem.dateofBirth!, birthPlace: userItem.placeofBirth, gender: userItem.gender, city: userItem.city, phone: userItem.phone, mailAdress: userItem.mail, userPass: userPass, approved: newUser.approvedKVKK, userEducation: UserEducationModel(objectId: currentUser.objectId ?? "", userId: currentUserName, highSchoolName: studentInfoItem.highSchoolName, highSClassNumber: studentInfoItem.classNumber, departmentName: studentInfoItem.departmentName, targetUniversity: studentInfoItem.targetUniversity, targetDepartment: studentInfoItem.targetDepartment))
                    }
                } else {
                    self.errorWarning(titleText: "Hata", des: "Alanlar boş bırakılamaz.")
                }
            } else {
                if userItem.targetString != "" && userItem.name != "" && userItem.dateofBirth?.timeIntervalSince1970 != 0 && userItem.gender != ""  && userItem.phone != "" && userItem.mail != "" && studentInfoItem.targetUniversity != "" && studentInfoItem.targetDepartment != "" && newUser.approvedKVKK != false {
                    
                    if var studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                        if studentEducationItem.education101inoNum != 1 {
                            studentEducationItem.education101aiNum = 2
                            studentEducationItem.education101inoNum = 1
                            studentEducationItem.education101iotNum = 3
                            studentEducationItem.mainEducation = "Inovation"
                            studentEducationItem.mainEducationValue = 101
                            studentEducationItem.mainEducationCellNum = 0
                            studentEducationItem.currentEducationNum = 0
                            studentEducationItem.currentCell = 0
                            studentEducationItem.questionAreaCell = 0
                            if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                                let arrayCount = EducationServices.getList(by: education.rawValue, mainEduValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum).count
                                studentEducationItem.currentEducationsCount = arrayCount
                            }
//                            studentEducationItem.score = 0
                            StudentEducationProvider.update(studentEducations: studentEducationItem)
                            
                            LyieUtils.updateUserEducationProgress(userEducationProgress: UserEducationProgressInfo(objectId:  PFUser.current()?.objectId ?? "", userID: PFUser.current()?.username ?? "", education101iotNum: studentEducationItem.education101iotNum, education101aiNum: studentEducationItem.education101aiNum, education101inoNum: studentEducationItem.education101inoNum, mainEducation: studentEducationItem.mainEducation, mainEducationValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum, currentEducationNum: studentEducationItem.currentEducationNum, currentEducationsCount: LyieUtils.objectCountValue(), currentCell: studentEducationItem.currentCell, questionAreaCell: studentEducationItem.questionAreaCell, questionAreaMainEdu: studentEducationItem.mainEducation, questionAreaMainValue: studentEducationItem.mainEducationValue))
                            
                        } else {
                            studentEducationItem.education101aiNum = 2
                            studentEducationItem.education101inoNum = 1
                            studentEducationItem.education101iotNum = 3
                            studentEducationItem.mainEducation = "Inovation"
                            studentEducationItem.mainEducationValue = 101
                            studentEducationItem.mainEducationCellNum = 0
                            studentEducationItem.currentEducationNum = 0
                            studentEducationItem.currentCell = 0
                            studentEducationItem.questionAreaCell = 0
//                            studentEducationItem.score = 0
                            if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                                let arrayCount = EducationServices.getList(by: education.rawValue, mainEduValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum).count
                                studentEducationItem.currentEducationsCount = arrayCount
                            }
                            StudentEducationProvider.update(studentEducations: studentEducationItem)
                            
                            
                            LyieUtils.updateUserEducationProgress(userEducationProgress: UserEducationProgressInfo(objectId:  PFUser.current()?.objectId ?? "", userID: PFUser.current()?.username ?? "", education101iotNum: studentEducationItem.education101iotNum, education101aiNum: studentEducationItem.education101aiNum, education101inoNum: studentEducationItem.education101inoNum, mainEducation: studentEducationItem.mainEducation, mainEducationValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum, currentEducationNum: studentEducationItem.currentEducationNum, currentEducationsCount: LyieUtils.objectCountValue(), currentCell: studentEducationItem.currentCell, questionAreaCell: studentEducationItem.questionAreaCell, questionAreaMainEdu: studentEducationItem.mainEducation, questionAreaMainValue: studentEducationItem.mainEducationValue))
                        }
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        let controller: DashboardController = UIStoryboard.dashboard.instantiateViewController()
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                } else {
                    self.errorWarning(titleText: "Hata", des: "Alanlar boş bırakılamaz.")
                }
            }
        }
    }
    
    func secondCheck() {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user), let studentInfoItem = StudentInfoProvider.studentInfos(for: user), let studentEducationItem = StudentEducationProvider.studentEducations(for: user), let newUser = NewUserProvider.users(for: user) {
            if userItem.userType == "Student" {
                if userItem.targetString != "" && userItem.name != "" && userItem.dateofBirth?.timeIntervalSince1970 != 0 && userItem.gender != ""  && userItem.phone != "" && userItem.mail != "" && studentInfoItem.highSchoolName != "" && studentInfoItem.classNumber != "" && studentInfoItem.departmentName != "" && studentInfoItem.targetUniversity != "" && studentInfoItem.targetDepartment != "" && newUser.approvedKVKK != false {
                    if let currentUser = PFUser.current(), let currentUserName = currentUser.username {
                        LyieUtils.updateUser(target: userItem.targetString, fullName: userItem.name, birthDay: userItem.dateofBirth!, birthPlace: userItem.placeofBirth, gender: userItem.gender, city: userItem.city, phone: userItem.phone, mailAdress: userItem.mail, userPass: userPass, approved: newUser.approvedKVKK, userEducation: UserEducationModel(objectId: currentUser.objectId ?? "", userId: currentUserName, highSchoolName: studentInfoItem.highSchoolName, highSClassNumber: studentInfoItem.classNumber, departmentName: studentInfoItem.departmentName, targetUniversity: studentInfoItem.targetUniversity, targetDepartment: studentInfoItem.targetDepartment))
//                        LyieUtils.updateUserEducationProgress(userEducationProgress: UserEducationProgressInfo(objectId:  PFUser.current()?.objectId ?? "", userID: PFUser.current()?.username ?? "", education101iotNum: studentEducationItem.education101iotNum, education101aiNum: studentEducationItem.education101aiNum, education101inoNum: studentEducationItem.education101inoNum, mainEducation: studentEducationItem.mainEducation, mainEducationValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum, currentEducationNum: studentEducationItem.currentEducationNum, currentEducationsCount: LyieUtils.objectCountValue(), currentCell: studentEducationItem.currentCell, questionAreaCell: 0, questionAreaMainEdu: studentEducationItem.mainEducation, questionAreaMainValue: studentEducationItem.mainEducationValue))
                    }
                    
                    let controller: ProfileUpdateSecondTableViewController = UIStoryboard.loginRegister.instantiateViewController()
                    self.navigationController?.pushViewController(controller, animated: true)
                } else {
                    self.errorWarning(titleText: "Hata", des: "Alanlar boş bırakılamaz.")
                }
            } else {
                if userItem.targetString != "" && userItem.name != "" && userItem.dateofBirth?.timeIntervalSince1970 != 0 && userItem.gender != ""  && userItem.phone != "" && userItem.mail != "" && studentInfoItem.targetUniversity != "" && studentInfoItem.targetDepartment != "" && newUser.approvedKVKK != false {
                    if var studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                        if studentEducationItem.education101inoNum != 1 {
                            studentEducationItem.education101aiNum = 2
                            studentEducationItem.education101inoNum = 1
                            studentEducationItem.education101iotNum = 3
                            studentEducationItem.mainEducation = "Inovation"
                            studentEducationItem.mainEducationValue = 101
                            studentEducationItem.mainEducationCellNum = 0
                            studentEducationItem.currentEducationNum = 0
                            studentEducationItem.currentCell = 0
                            studentEducationItem.questionAreaCell = 0
                            if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                                let arrayCount = EducationServices.getList(by: education.rawValue, mainEduValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum).count
                                studentEducationItem.currentEducationsCount = arrayCount
                            }
//                                    studentEducationItem.score = 0
                            StudentEducationProvider.update(studentEducations: studentEducationItem)
                            LyieUtils.updateUser(target: userItem.targetString, fullName: userItem.name, birthDay: userItem.dateofBirth!, birthPlace: userItem.placeofBirth, gender: userItem.gender, city: userItem.city, phone: userItem.phone, mailAdress: userItem.mail, userPass: userPass, approved: newUser.approvedKVKK, userEducation: UserEducationModel(objectId: PFUser.current()?.objectId ?? "", userId: PFUser.current()?.username ?? "", highSchoolName: studentInfoItem.highSchoolName, highSClassNumber: studentInfoItem.classNumber, departmentName: studentInfoItem.departmentName, targetUniversity: studentInfoItem.targetUniversity, targetDepartment: studentInfoItem.targetDepartment))
                            LyieUtils.updateUserEducationProgress(userEducationProgress: UserEducationProgressInfo(objectId:  PFUser.current()?.objectId ?? "", userID: PFUser.current()?.username ?? "", education101iotNum: studentEducationItem.education101iotNum, education101aiNum: studentEducationItem.education101aiNum, education101inoNum: studentEducationItem.education101inoNum, mainEducation: studentEducationItem.mainEducation, mainEducationValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum, currentEducationNum: studentEducationItem.currentEducationNum, currentEducationsCount: LyieUtils.objectCountValue(), currentCell: studentEducationItem.currentCell, questionAreaCell: studentEducationItem.questionAreaCell, questionAreaMainEdu: studentEducationItem.mainEducation, questionAreaMainValue: studentEducationItem.mainEducationValue))
                        } else {
                            studentEducationItem.education101aiNum = 2
                            studentEducationItem.education101inoNum = 1
                            studentEducationItem.education101iotNum = 3
                            studentEducationItem.mainEducation = "Inovation"
                            studentEducationItem.mainEducationValue = 101
                            studentEducationItem.mainEducationCellNum = 0
                            studentEducationItem.currentEducationNum = 0
                            studentEducationItem.currentCell = 0
                            studentEducationItem.questionAreaCell = 0
//                            studentEducationItem.score = 0
                            if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                                let arrayCount = EducationServices.getList(by: education.rawValue, mainEduValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum).count
                                studentEducationItem.currentEducationsCount = arrayCount
                            }
                            StudentEducationProvider.update(studentEducations: studentEducationItem)
                            
                            LyieUtils.updateUser(target: userItem.targetString, fullName: userItem.name, birthDay: userItem.dateofBirth!, birthPlace: userItem.placeofBirth, gender: userItem.gender, city: userItem.city, phone: userItem.phone, mailAdress: userItem.mail, userPass: userPass, approved: newUser.approvedKVKK, userEducation: UserEducationModel(objectId: PFUser.current()?.objectId ?? "", userId: PFUser.current()?.username ?? "", highSchoolName: studentInfoItem.highSchoolName, highSClassNumber: studentInfoItem.classNumber, departmentName: studentInfoItem.departmentName, targetUniversity: studentInfoItem.targetUniversity, targetDepartment: studentInfoItem.targetDepartment))
                            LyieUtils.updateUserEducationProgress(userEducationProgress: UserEducationProgressInfo(objectId:  PFUser.current()?.objectId ?? "", userID: PFUser.current()?.username ?? "", education101iotNum: studentEducationItem.education101iotNum, education101aiNum: studentEducationItem.education101aiNum, education101inoNum: studentEducationItem.education101inoNum, mainEducation: studentEducationItem.mainEducation, mainEducationValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum, currentEducationNum: studentEducationItem.currentEducationNum, currentEducationsCount: LyieUtils.objectCountValue(), currentCell: studentEducationItem.currentCell, questionAreaCell: studentEducationItem.questionAreaCell, questionAreaMainEdu: studentEducationItem.mainEducation, questionAreaMainValue: studentEducationItem.mainEducationValue))
                        }
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        let controller: DashboardController = UIStoryboard.dashboard.instantiateViewController()
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                } else {
                    if userItem.userType == "User" {
                        if var studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                            studentEducationItem.education101aiNum = 2
                            studentEducationItem.education101inoNum = 1
                            studentEducationItem.education101iotNum = 3
                            studentEducationItem.mainEducation = "Inovation"
                            studentEducationItem.mainEducationValue = 101
                            studentEducationItem.mainEducationCellNum = 0
                            studentEducationItem.currentEducationNum = 0
                            studentEducationItem.currentCell = 0
                            studentEducationItem.questionAreaCell = 0
//                            studentEducationItem.score = 0
                            if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                                let arrayCount = EducationServices.getList(by: education.rawValue, mainEduValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum).count
                                studentEducationItem.currentEducationsCount = arrayCount
                            }
                            StudentEducationProvider.update(studentEducations: studentEducationItem)

                            if userItem.dateofBirth == nil {
                                let date = Date()
                                userItem.dateofBirth = date
                                UserProvider.update(users: userItem)
                            }
                            
                            LyieUtils.updateUser(target: userItem.targetString, fullName: userItem.name, birthDay: userItem.dateofBirth!, birthPlace: userItem.placeofBirth, gender: userItem.gender, city: userItem.city, phone: userItem.phone, mailAdress: userItem.mail, userPass: userPass, approved: newUser.approvedKVKK, userEducation: UserEducationModel(objectId: PFUser.current()?.objectId ?? "", userId: PFUser.current()?.username ?? "", highSchoolName: studentInfoItem.highSchoolName, highSClassNumber: studentInfoItem.classNumber, departmentName: studentInfoItem.departmentName, targetUniversity: studentInfoItem.targetUniversity, targetDepartment: studentInfoItem.targetDepartment))
                            
                            LyieUtils.updateUserEducationProgress(userEducationProgress: UserEducationProgressInfo(objectId:  PFUser.current()?.objectId ?? "", userID: PFUser.current()?.username ?? "", education101iotNum: studentEducationItem.education101iotNum, education101aiNum: studentEducationItem.education101aiNum, education101inoNum: studentEducationItem.education101inoNum, mainEducation: studentEducationItem.mainEducation, mainEducationValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum, currentEducationNum: studentEducationItem.currentEducationNum, currentEducationsCount: LyieUtils.objectCountValue(), currentCell: studentEducationItem.currentCell, questionAreaCell: studentEducationItem.questionAreaCell, questionAreaMainEdu: studentEducationItem.mainEducation, questionAreaMainValue: studentEducationItem.mainEducationValue))
                            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                            let controller: DashboardController = UIStoryboard.dashboard.instantiateViewController()
                            self.navigationController?.pushViewController(controller, animated: true)
                        }
                    } else {
                        self.errorWarning(titleText: "Hata", des: "Alanlar boş bırakılamaz.")
                    }
                }
            }
        }
    }
}

