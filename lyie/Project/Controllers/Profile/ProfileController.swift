//
//  ProfileController.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit
import PopupDialog
import Parse

enum profileType: Int {
    case first = 0
    case second = 1
    case third = 2
}

class ProfileController: UIViewController, UITableViewDelegate, UITableViewDataSource, Localizable, HomeMentorObserver {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var leftBarButtonIcon: UIImageView!
    @IBOutlet weak var rightBarButtonIcon: UIImageView!
    
    var userItem: UserItem?
    var popup: PopupDialog?
    var gender = ""
    let dateFormatter = DateFormatter()
    //    private var forceTextChangeDelegate: ForceTextChangeDelegate?
    var firstStudentCount = 0
    var secondStudentCount = 0
    func applyLanguage() {}
    
    var profileType: profileType = .first
    var firstStudentImageArray = [String]()
    var firstStudentNameArrray = [String]()
    var firstStudentHGArray = [String]()
    var firstStudentScoreArray = [String]()
    
    var secondStudentImageArray = [String]()
    var secondStudentNameArrray = [String]()
    var secondStudentHGArray = [String]()
    var secondStudentScoreArray = [String]()
    
    var userIdArray = [String]()
    var secondUserIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingLanguage()
        startObservingHomeMentors()
        profileType = .first
        config()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        getClassNum()
    }
    
    deinit {
        stopObservingLanguage()
        stopObservingHomeMentors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(HomeController.getData), name: NSNotification.Name("imageChanged"), object: nil)
        tabBarController?.hidesBottomBarWhenPushed = false
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func getData() {
        myTableView.reloadData()
    }
    
    @IBAction func tappedLeftBarButton(_ sender: Any) {}
    
    @IBAction func tappedRightButton(_ sender: Any) {
        LyieUtils.configureLogOutActionSheet(view: self)
    }
    
    func navigateScoreVC() {
        self.tabBarController?.selectedIndex = 4
    }
    
    func navigateProfileVC() {
        self.tabBarController?.selectedIndex = 1
    }
    
    func navigateMentorVC() {
        self.tabBarController?.selectedIndex = 3
    }
    
    func onDidChange(mentors: [HomeMentorInfo]) {
        myTableView.reloadData()
    }
}

extension ProfileController {
    
    func config() {
        logoView.backgroundColor = StyleManager.colors.white
        logoIcon.image = UIImage(named: "Dashboard/inovatim")
        logoView.makeShadow()
        shadowView.makeShadow()
        logoView.topBottomMakeShadow()
        leftBarButtonIcon.isHidden = true
        
        self.tabBarController?.tabBar.backgroundColor = StyleManager.colors.white
        self.tabBarController?.tabBar.tintColor = StyleManager.colors.leftTitleColor
        myTableView.backgroundColor = StyleManager.colors.backgroundColor
        myTableView.register(UINib(nibName: HomeMentorCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: HomeMentorCell.reuseIdentifier)
        myTableView.register(UINib(nibName: PersonalInfoCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: PersonalInfoCell.reuseIdentifier)
        myTableView.register(UINib(nibName: EducationInfoCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: EducationInfoCell.reuseIdentifier)
        myTableView.register(UINib(nibName: EducationInfoMentorCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: EducationInfoMentorCell.reuseIdentifier)
        myTableView.register(UINib(nibName: SortedCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: SortedCell.reuseIdentifier)
        myTableView.register(UINib(nibName: ClassStudentCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: ClassStudentCell.reuseIdentifier)
    }
}

extension ProfileController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch profileType {
        case .first:
            return 4
        case .second:
            return firstStudentCount + 2
        case .third:
            return secondStudentCount + 2
        default:
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: HomeMentorCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config(isHidden: true)
            cell.navigateScoreTapAction = { cell in
                self.navigateScoreVC()
            }
            cell.navigateProfileTapAction = { cell in
                self.navigateProfileVC()
            }
            cell.photoChangingTapAction = {cell in
                self.configureCameraActionSheet()
            }
            cell.navigateMentorTapAction = {cell in
                self.navigateMentorVC()
            }
            
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell: SortedCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config()
            
            cell.navigateProfileDetailAction = { cell in
                self.profileType = .first
                self.myTableView.reloadData()
            }
            
            cell.navigateClassDetailAction = { cell in
                self.profileType = .second
                self.myTableView.reloadData()
            }
            
            cell.navigateSecondClassDetailAction = { cell in
                self.profileType = .third
                self.myTableView.reloadData()
            }
            
            cell.selectionStyle = .none
            return cell
        case 2:
            switch profileType {
            case .first:
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
                    //                self.showCity(animated: true, placeOfBirth: true)
                    self.showSearch(type: 4)
                }
                
                //GENDER
                cell.navigateGenderTapAction = { cell in
                    self.showStringPicker(pickerType: 0)
                }
                
                //CITY
                cell.navigateCityTapAction = { cell in
                    //                self.showCity(animated: true, placeOfBirth: false)
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
            case .second:
                let cell: ClassStudentCell = tableView.dequeueReusableCell(at: indexPath)
                
                if !firstStudentNameArrray.isEmpty && !firstStudentImageArray.isEmpty && !firstStudentScoreArray.isEmpty && !firstStudentHGArray.isEmpty {
                    if firstStudentCount != 1 {
                        cell.config(isHidden: false, nameText: firstStudentNameArrray[0], hgName: firstStudentHGArray[0], score: firstStudentScoreArray[0], imageS: firstStudentImageArray[0])
                    } else {
                        cell.config(isHidden: true, nameText: firstStudentNameArrray[0], hgName: firstStudentHGArray[0], score: firstStudentScoreArray[0], imageS: firstStudentImageArray[0])
                    }
                    
                } else {
                    cell.config(isHidden: false, nameText: "", hgName: "", score: "", imageS: "")
                }
                
                cell.selectionStyle = .none
                return cell
            case .third:
                let cell: ClassStudentCell = tableView.dequeueReusableCell(at: indexPath)
                
                if !secondStudentNameArrray.isEmpty && !secondStudentImageArray.isEmpty && !secondStudentScoreArray.isEmpty && !secondStudentHGArray.isEmpty {
                    if secondStudentCount != 1 {
                        cell.config(isHidden: false, nameText: secondStudentNameArrray[0], hgName: secondStudentHGArray[0], score: secondStudentScoreArray[0], imageS: secondStudentImageArray[0])
                    } else {
                        cell.config(isHidden: true, nameText: secondStudentNameArrray[0], hgName: secondStudentHGArray[0], score: secondStudentScoreArray[0], imageS: secondStudentImageArray[0])
                    }
                    
                } else {
                    cell.config(isHidden: false, nameText: "", hgName: "", score: "", imageS: "")
                }
                
                cell.selectionStyle = .none
                return cell
            }
            
        case 3:
            switch profileType {
            case .first:
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
            case .second:
                let cell: ClassStudentCell = tableView.dequeueReusableCell(at: indexPath)
                if !firstStudentNameArrray.isEmpty && !firstStudentImageArray.isEmpty && !firstStudentScoreArray.isEmpty && !firstStudentHGArray.isEmpty {
                    if firstStudentCount != 2 {
                        cell.config(isHidden: false, nameText: firstStudentNameArrray[1], hgName: firstStudentHGArray[1], score: firstStudentScoreArray[1], imageS: firstStudentImageArray[1])
                    } else {
                        cell.config(isHidden: true, nameText: firstStudentNameArrray[1], hgName: firstStudentHGArray[1], score: firstStudentScoreArray[1], imageS: firstStudentImageArray[1])
                    }
                } else {
                    cell.config(isHidden: false, nameText: "", hgName: "", score: "", imageS: "")
                }
                
                cell.selectionStyle = .none
                return cell
            case .third:
                let cell: ClassStudentCell = tableView.dequeueReusableCell(at: indexPath)
                if !secondStudentNameArrray.isEmpty && !secondStudentImageArray.isEmpty && !secondStudentScoreArray.isEmpty && !secondStudentHGArray.isEmpty {
                    if secondStudentCount != 2 {
                        cell.config(isHidden: false, nameText: secondStudentNameArrray[1], hgName: secondStudentHGArray[1], score: secondStudentScoreArray[1], imageS: secondStudentImageArray[1])
                    } else {
                        cell.config(isHidden: true, nameText: secondStudentNameArrray[1], hgName: secondStudentHGArray[1], score: secondStudentScoreArray[1], imageS: secondStudentImageArray[1])
                    }
                } else {
                    cell.config(isHidden: false, nameText: "", hgName: "", score: "", imageS: "")
                }
                
                cell.selectionStyle = .none
                return cell
            }
            
        default:
            if profileType == .second {
                if indexPath.row == firstStudentCount + 1 {
                    let cell: ClassStudentCell = tableView.dequeueReusableCell(at: indexPath)
                    let index = indexPath.row - 2
                    if firstStudentNameArrray.isEmpty && firstStudentHGArray.isEmpty && firstStudentScoreArray.isEmpty && firstStudentImageArray.isEmpty {
                        cell.config(isHidden: true, nameText: "", hgName: "", score: "", imageS: "")
                    } else {
                        cell.config(isHidden: true, nameText: firstStudentNameArrray[index], hgName: firstStudentHGArray[index], score: firstStudentScoreArray[index], imageS: firstStudentImageArray[index])
                    }
                    
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let index = indexPath.row - 2
                    let cell: ClassStudentCell = tableView.dequeueReusableCell(at: indexPath)
                    if firstStudentNameArrray.isEmpty && firstStudentHGArray.isEmpty && firstStudentScoreArray.isEmpty && firstStudentImageArray.isEmpty {
                        cell.config(isHidden: false, nameText: "", hgName: "", score: "", imageS: "")
                    } else {
                        cell.config(isHidden: false, nameText: firstStudentNameArrray[index], hgName: firstStudentHGArray[index], score: firstStudentScoreArray[index], imageS: firstStudentImageArray[index])
                    }
                    
                    cell.selectionStyle = .none
                    return cell
                }
            } else {
                if indexPath.row == secondStudentCount + 1 {
                    let cell: ClassStudentCell = tableView.dequeueReusableCell(at: indexPath)
                    let index = indexPath.row - 2
                    if secondStudentNameArrray.isEmpty && secondStudentHGArray.isEmpty && secondStudentScoreArray.isEmpty && secondStudentImageArray.isEmpty {
                        cell.config(isHidden: true, nameText: "", hgName: "", score: "", imageS: "")
                    } else {
                        cell.config(isHidden: true, nameText: secondStudentNameArrray[index], hgName: secondStudentHGArray[index], score: secondStudentScoreArray[index], imageS: secondStudentImageArray[index])
                    }
                    
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let index = indexPath.row - 2
                    let cell: ClassStudentCell = tableView.dequeueReusableCell(at: indexPath)
                    if secondStudentNameArrray.isEmpty && secondStudentHGArray.isEmpty && secondStudentScoreArray.isEmpty && secondStudentImageArray.isEmpty {
                        cell.config(isHidden: false, nameText: "", hgName: "", score: "", imageS: "")
                    } else {
                        cell.config(isHidden: false, nameText: secondStudentNameArrray[index], hgName: secondStudentHGArray[index], score: secondStudentScoreArray[index], imageS: secondStudentImageArray[index])
                    }
                    
                    cell.selectionStyle = .none
                    return cell
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 375.0
        case 1:
            return 120.0
        case 2:
            switch profileType {
            case .first:
                return 390.0
            default:
                return 150.0
            }
        case 3:
            switch profileType {
            case .first:
                if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey), let userItem = UserProvider.users(for: currentUserInfo) {
                    if userItem.userType == "Mentor" {
                        return 200.0
                    } else {
                        return 300
                    }
                } else {
                    return 300.0
                }
            default:
                return 150.0
            }
        default:
            return 150.0
        }
    }
}

extension ProfileController {
    
    ///Returns localized gender string
    func genderLocalized(genderString: String) -> String {
        if genderString == "male" || genderString == "Male" || genderString == "erkek" || genderString == "Erkek" {
            return .localized(.male)
        } else {
            return .localized(.female)
        }
    }
}

//MARK: - TFDelegate DELEGATE
extension ProfileController: TFDelegate {
    func onChangeText(nameSurname: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else {
            return
        }
        userItem.name = nameSurname
        UserProvider.update(users: userItem)
        LyieUtils.profileFullNameUpdate(text: nameSurname)
        self.myTableView.reloadData()
    }
    
    func onChangeText(mail: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else {
            return
        }
        userItem.mail = mail
        UserProvider.update(users: userItem)
        LyieUtils.profileMailUpdated(text: mail)
        self.myTableView.reloadData()
    }
    
    func onChangeText(phone: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else {
            return
        }
        userItem.phone = phone
        UserProvider.update(users: userItem)
        LyieUtils.profilePhoneUpdate(text: phone)
        self.myTableView.reloadData()
    }
    
    func onChangeText(highSchollName: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else {
            return
        }
        studentInfoItem.highSchoolName = highSchollName
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        LyieUtils.profileHGUpdate(text: highSchollName)
        self.myTableView.reloadData()
    }
    
    func onChangeText(targetUni: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else {
            return
        }
        studentInfoItem.targetUniversity = targetUni
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        LyieUtils.profileTarrgetUniUpdated(text: targetUni)
        self.myTableView.reloadData()
    }
    
    func onChangeText(targetDept: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else {
            return
        }
        studentInfoItem.targetDepartment = targetDept
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        LyieUtils.profileTargetDepUpdate(text: targetDept)
        self.myTableView.reloadData()
    }
    
    
    func onTFDismissed() {
        popup?.dismiss()
    }
}

//MARK: - TVDelegate DELEGATE
extension ProfileController: TVDelegate {
    
    func onChangeText(target: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else {
            return
        }
        userItem.targetString = target
        UserProvider.update(users: userItem)
        LyieUtils.profileTargetStringUpdate(text: target)
        self.myTableView.reloadData()
    }
    
    func onChangeText(ques: String) {}
    
    func onChangeText(ans: String) {}
    
    func onTVDismissed() {
        popup?.dismiss()
    }
}

//MARK: - USERINFOPICKER DELEGATE
extension ProfileController: UserInfoPickerDelegate {
    func onGenderSet(gender: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else { return }
        userItem.gender = gender
        UserProvider.update(users: userItem)
        LyieUtils.profileGenderUpdated(text: gender)
        self.myTableView.reloadData()
    }
    
    func onAgeSet(date: Date) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else {
            return
        }
        userItem.dateofBirth = date
        UserProvider.update(users: userItem)
        LyieUtils.profileBirthdayUpdate(text: date)
        self.myTableView.reloadData()
    }
    
    func onClassSet(classNumber: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else { return }
        studentInfoItem.classNumber = classNumber
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        LyieUtils.profileClassUpdate(text: classNumber)
        self.myTableView.reloadData()
    }
    
    func onDepartmentSet(departmentName: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else { return }
        studentInfoItem.departmentName = departmentName
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        LyieUtils.profileHGDeprtUpdate(text: departmentName)
        self.myTableView.reloadData()
    }
    
    func onPickerDismissed() {
        DispatchQueue.main.async {
            self.popup?.dismiss()
        }
    }
}

extension ProfileController: SearchDelegate {
    func onChangeText(targetUniName: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else {
            return
        }
        studentInfoItem.targetUniversity = targetUniName
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        LyieUtils.profileTarrgetUniUpdated(text: targetUniName)
        self.myTableView.reloadData()
    }
    
    func onChangeText(targetDeptName: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else {
            return
        }
        studentInfoItem.targetDepartment = targetDeptName
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        LyieUtils.profileTargetDepUpdate(text: targetDeptName)
        self.myTableView.reloadData()
    }
    
    func onChangeText(hSchoolName: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else {
            return
        }
        studentInfoItem.highSchoolName = hSchoolName
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        LyieUtils.profileHGUpdate(text: hSchoolName)
        self.myTableView.reloadData()
    }
    
    func onCitySet(city: Int) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else {
            return
        }
        userItem.city = city
        UserProvider.update(users: userItem)
        LyieUtils.profileCityUpdated(text: city)
        self.myTableView.reloadData()
    }
    
    func onPlaceOfBirthSet(city: Int) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) else {
            return
        }
        userItem.placeofBirth = city
        UserProvider.update(users: userItem)
        LyieUtils.profilePlaceBirthUpdate(text: city)
        self.myTableView.reloadData()
    }
    
    func onChangeText(hSchoolDept: String) {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), var studentInfoItem = StudentInfoProvider.studentInfos(for: user) else {
            return
        }
        studentInfoItem.departmentName = hSchoolDept
        StudentInfoProvider.update(studentInfos: studentInfoItem)
        LyieUtils.profileHGDeprtUpdate(text: hSchoolDept)
        self.myTableView.reloadData()
    }
    
    func onChangeText(newUserUni: String) {}
    
    func onChangeText(newUserHG: String) {}
    
    func onChangeText(newUserDept: String) {}
    
    func onDismissed() {
        DispatchQueue.main.async {
            self.popup?.dismiss()
        }
    }
}

extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    ///Present action sheet options gallery/camera
    func configureCameraActionSheet() {
        var alertStyle = UIAlertController.Style.actionSheet
        
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
            let camera = UIAlertAction(title: "Fotoğraf Çek", style: .default) { action in
                self.openCamera()
            }
            let gallery = UIAlertAction(title: "Galeriden seç", style: .default) { action in
                self.openGallery()
            }
            
            actionSheet.addAction(camera)
            actionSheet.addAction(gallery)
            actionSheet.addAction(cancel)
            
            self.present(actionSheet, animated: true, completion: nil)
        } else {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cancel = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
            let camera = UIAlertAction(title: "Fotoğraf Çek", style: .default) { action in
                self.openCamera()
            }
            let gallery = UIAlertAction(title: "Galeriden seç", style: .default) { action in
                self.openGallery()
            }
            
            actionSheet.addAction(camera)
            actionSheet.addAction(gallery)
            actionSheet.addAction(cancel)
            
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    func openCamera() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    
    func openGallery() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let cell: HomeMentorCell = myTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! HomeMentorCell
            cell.profilePic.image = image
            LyieUtils.uploadProfilePic(image: image, cell: cell.profilePic)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "imageChanged"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProfileController {
    //first
    func getClassNum() {
        self.firstStudentImageArray.removeAll(keepingCapacity: false)
        self.firstStudentNameArrray.removeAll(keepingCapacity: false)
        self.firstStudentHGArray.removeAll(keepingCapacity: false)
        self.firstStudentScoreArray.removeAll(keepingCapacity: false)
        self.userIdArray.removeAll(keepingCapacity: false)
        
        if let currentUser = PFUser.current() {
            if let query = PFUser.query() {
                query.whereKey("username", equalTo: currentUser.username!)
                query.getFirstObjectInBackground { (object, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                    } else {
                        if let object = object {
                            let classInfo = object.relation(forKey: "studentClassInfo")
                            classInfo.query().getFirstObjectInBackground { (objsClass, error) in
                                if error != nil {
                                    print(error?.localizedDescription)
                                    let classInfo = object.relation(forKey: "mentorInfo")
                                    classInfo.query().getFirstObjectInBackground { (objsMentor, error) in
                                        if error != nil {
                                            print(error?.localizedDescription)
                                        } else {
                                            if let objsMentor = objsMentor {
                                                let classQuery = PFQuery(className: "ClassInfo")
                                                classQuery.whereKey("classID", equalTo: objsMentor.object(forKey: "FirstClass"))
                                                classQuery.findObjectsInBackground { (students, error) in
                                                    if error != nil {
                                                        print(error?.localizedDescription)
                                                    } else {
                                                        if let students = students {
                                                            self.firstStudentCount = students.count
                                                            print("count:", self.firstStudentCount)
                                                            print("students.count", students.count)
                                                            for student in students {
                                                                self.userIdArray.append(student.object(forKey: "StudentId") as? String ?? "")
                                                            }
                                                            self.studentInfo()
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    if let objsClass = objsClass {
                                        if let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) {
                                            userItem.classID = objsClass.object(forKey: "classID") as? String ?? ""
                                            UserProvider.update(users: userItem)
                                        }
                                        
                                        let classQuery = PFQuery(className: "ClassInfo")
                                        classQuery.whereKey("classID", equalTo: objsClass.object(forKey: "classID"))
                                        classQuery.findObjectsInBackground { (students, error) in
                                            if error != nil {
                                                print(error?.localizedDescription)
                                            } else {
                                                if let students = students {
                                                    self.firstStudentCount = students.count - 1
                                                    print("count:", self.firstStudentCount)
                                                    print("students.count", students.count)
                                                    for student in students {
                                                        if (student.object(forKey: "StudentId") as! String) != (PFUser.current()?.object(forKey: "username") as! String) {
                                                            self.userIdArray.append(student.object(forKey: "StudentId") as? String ?? "")
                                                        }
                                                    }
                                                    self.studentInfo()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            self.studentInfo()
        }
    }
    
    func getSecondClassNum() {
        self.secondStudentImageArray.removeAll(keepingCapacity: false)
        self.secondStudentNameArrray.removeAll(keepingCapacity: false)
        self.secondStudentHGArray.removeAll(keepingCapacity: false)
        self.secondStudentScoreArray.removeAll(keepingCapacity: false)
        self.secondUserIdArray.removeAll(keepingCapacity: false)
        if let currentUser = PFUser.current() {
            if let query = PFUser.query() {
                query.whereKey("username", equalTo: currentUser.username!)
                query.findObjectsInBackground { (objects, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                    } else {
                        if let objects = objects {
                            if objects.first != nil {
                                let classInfo = objects.first!.relation(forKey: "mentorInfo")
                                classInfo.query().getFirstObjectInBackground { (objs, error) in
                                    if error != nil {
                                        print(error?.localizedDescription)
                                    } else {
                                        if let objs = objs {
                                            
                                            print("\(objs.object(forKey: "SecondClass"))")
                                            let classQuery = PFQuery(className: "ClassInfo")
                                            classQuery.whereKey("classID", equalTo: objs.object(forKey: "SecondClass"))
                                            classQuery.findObjectsInBackground { (students, error) in
                                                if error != nil {
                                                    print(error?.localizedDescription)
                                                } else {
                                                    if let students = students {
                                                        self.secondStudentCount = students.count
                                                        print("count:", self.secondStudentCount)
                                                        print("students.count", students.count)
                                                        for student in students {
                                                            self.secondUserIdArray.append(student.object(forKey: "StudentId") as? String ?? "")
                                                        }
                                                        self.secondStudentInfo()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            self.secondStudentInfo()
        }
    }
    
    func studentInfo() {
        for i in 0..<userIdArray.count {
            if let userQuery = PFUser.query() {
                userQuery.whereKey("username", equalTo: userIdArray[i])
                userQuery.getFirstObjectInBackground { (studentsObj, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        self.firstStudentCount = 0
                    } else {
                        if let studentsObj = studentsObj {
                            if studentsObj.object(forKey: "fullName") != nil {
                                self.firstStudentNameArrray.append(studentsObj.object(forKey: "fullName") as? String ?? "")
                            } else {
                                self.firstStudentNameArrray.append("")
                            }
                            
                            if studentsObj.object(forKey: "userImageUrl") != nil {
                                self.firstStudentImageArray.append(studentsObj.object(forKey: "userImageUrl") as? String ?? "")
                            } else {
                                self.firstStudentImageArray.append("")
                            }
                            
                            
                            let hgInfo = studentsObj.relation(forKey: "userEducation")
                            hgInfo.query().getFirstObjectInBackground(block: { (hgObj, error) in
                                if error != nil {
                                    print(error?.localizedDescription)
                                    self.firstStudentHGArray.append("")
                                } else {
                                    if let hgObj = hgObj {
                                        if hgObj.object(forKey: "highSchoolName") != nil {
                                            self.firstStudentHGArray.append(hgObj.object(forKey: "highSchoolName") as? String ?? "")
                                        } else {
                                            self.firstStudentHGArray.append("")
                                        }
                                    } else {
                                        self.firstStudentHGArray.append("")
                                    }
                                }
                            })
                            
                            
                            let scoreInfo = studentsObj.relation(forKey: "userScore")
                            scoreInfo.query().order(byDescending: "CreatedAt")
                            scoreInfo.query().getFirstObjectInBackground { obj, error in
                                if error != nil {
                                    print(error?.localizedDescription)
                                    self.firstStudentScoreArray.append("0")
                                    if self.userItem?.userType == "Mentor" {
                                        self.getSecondClassNum()
                                    }
                                } else {
                                    if let obj = obj {
                                        let value = obj["totalScore"] as? Int ?? 0
                                        self.firstStudentScoreArray.append("\(value)")
                                        self.getSecondClassNum()
                                    } else {
                                        self.firstStudentScoreArray.append("0")
                                        self.getSecondClassNum()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func secondStudentInfo() {
        for i in 0..<secondUserIdArray.count {
            if let userQuery = PFUser.query() {
                userQuery.whereKey("username", equalTo: secondUserIdArray[i])
                userQuery.getFirstObjectInBackground { (specificStu, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        self.secondStudentCount = 0
                    } else {
                        if let specificStu = specificStu {
                            if specificStu.object(forKey: "fullName") != nil {
                                self.secondStudentNameArrray.append(specificStu.object(forKey: "fullName") as? String ?? "")
                            } else {
                                self.secondStudentNameArrray.append("")
                            }
                            
                            if specificStu.object(forKey: "userImageUrl") != nil {
                                self.secondStudentImageArray.append(specificStu.object(forKey: "userImageUrl") as? String ?? "")
                            } else {
                                self.secondStudentImageArray.append("")
                            }
                            
                            
                            let hgInfo = specificStu.relation(forKey: "userEducation")
                            hgInfo.query().getFirstObjectInBackground(block: { (hgObj, error) in
                                if error != nil {
                                    print(error?.localizedDescription)
                                    self.secondStudentHGArray.append("")
                                } else {
                                    if let hgObj = hgObj {
                                        if hgObj.object(forKey: "highSchoolName") != nil {
                                            self.secondStudentHGArray.append(hgObj.object(forKey: "highSchoolName") as? String ?? "")
                                        } else {
                                            self.secondStudentHGArray.append("")
                                        }
                                    } else {
                                        self.secondStudentHGArray.append("")
                                    }
                                }
                            })
                            
                            
                            let scoreInfo = specificStu.relation(forKey: "userScore")
                            scoreInfo.query().order(byDescending: "CreatedAt")
                            scoreInfo.query().getFirstObjectInBackground { obj, error in
                                if error != nil {
                                    print(error?.localizedDescription)
                                    self.secondStudentScoreArray.append("0")
                                } else {
                                    if let obj = obj {
                                        let value = obj["totalScore"] as? Int ?? 0
                                        self.secondStudentScoreArray.append("\(value)")
                                    } else {
                                        self.secondStudentScoreArray.append("0")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

