//
//  Education101Cell.swift
//  lyie
//
//  Created by Sevcan Eşim on 29.11.2020.
//

import UIKit
import Parse

enum EducationStep: String {
    case inovation = "Inovation"
    case iot = "Iot"
    case ai = "Ai"
}
class Education101Cell: UITableViewCell {
    static let reuseIdentifier = "Education101Cell"
    
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet weak var coverPhoto: UIImageView!
    @IBOutlet weak var leftTitleView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var educationTableView: UITableView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var mainEducationView: UIView!
    @IBOutlet weak var lockScreenView: UIView!
    @IBOutlet weak var lockScreenImageView: UIView!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var lockButtonView: UIView!
    
    var text1: String = ""
    var navigateNumberTapAction: ((Education101Cell) -> ())?
    var alertTapAction: ((Education101Cell) -> ())?
    var navigateTapAction: ((Education101Cell) -> ())?
    var educationStep: EducationStep = .inovation
    var isMentorUpdate = false
    var profileUpdate = false
    var index = 0
    var lockActive = false
    func config(Education: EducationStep, inoHidden: Bool, iotHidden: Bool, aiHidden: Bool, numberViewHidden: Bool, lockScreen: Bool, isProfileUpdate: Bool, isMentorUpdate: Bool) {
        self.isMentorUpdate = isMentorUpdate
        profileUpdate = isProfileUpdate
        educationStep = Education
        initTableView()
        mainEducationView.makeShadow()
        numberView.backgroundColor = .white
        numberView.isHidden = numberViewHidden
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.textColor = StyleManager.colors.leftTitleColor
        lineView.backgroundColor = StyleManager.colors.lineColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        
        
        
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            if studentEducationItem.education101aiNum == 0 && studentEducationItem.education101iotNum == 0  && studentEducationItem.education101inoNum == 0 {
                number.text = ""
            } else {
                switch Education {
                case .inovation:
                    if studentEducationItem.education101inoNum != 0 {
                        number.text = "\(studentEducationItem.education101inoNum)"
                    } else {
                        number.text = ""
                    }
                    
                case .iot:
                    if studentEducationItem.education101iotNum != 0 {
                        number.text = "\(studentEducationItem.education101iotNum)"
                    } else {
                        number.text = ""
                    }
                    
                case .ai:
                    if studentEducationItem.education101aiNum != 0 {
                        number.text = "\(studentEducationItem.education101aiNum)"
                    } else {
                        number.text = ""
                    }
                    
                default:
                    LyieLog.mPrint("default")
                }
            }
        }
        lockActive = lockScreen
        if lockScreen != false {
            if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                lockScreenView.isHidden = false
                lockScreenView.backgroundColor = StyleManager.colors.karartı
                lockScreenView.alpha = 0.30
                lockScreenView.isUserInteractionEnabled = false
                
                lockScreenImageView.isHidden = true
                lockScreenImageView.backgroundColor = StyleManager.colors.karartı
                lockScreenImageView.alpha = 0.95
                lockScreenImageView.isUserInteractionEnabled = false
                
                textView.isHidden = true
                if studentEducationItem.education101aiNum == 1 {
                    if studentEducationItem.education101inoNum == 2 && Education == .inovation {
                        text1 = "Bu eğitim ikinci tercihinde bulunmaktadır. Eğitim kilidini açmak için Yapay Zeka 101 eğitimini tamamlayınız."
                        textView.attributedText = text1.setAttributedString(changeText: "ikinci tercihinde", font: UIFont(name: "Klavika-Medium", size: 20)!, color: StyleManager.colors.redText, enableColor: .white)
                    }
                    if studentEducationItem.education101inoNum == 3 && Education == .inovation {
                        text1 = "Bu eğitim üçüncü tercihinde bulunmaktadır. Eğitim kilidini açmak için IoT 101 eğitimini tamamlayınız."
                        textView.attributedText = text1.setAttributedString(changeText: "üçüncü tercihinde", font: UIFont(name: "Klavika-Medium", size: 20)!, color: StyleManager.colors.redText, enableColor: .white)
                    }
                    if studentEducationItem.education101iotNum == 2 && Education == .iot {
                        text1 = "Bu eğitim ikinci tercihinde bulunmaktadır. Eğitim kilidini açmak için Yapay Zeka 101 eğitimini tamamlayınız."
                        textView.attributedText = text1.setAttributedString(changeText: "ikinci tercihinde", font: UIFont(name: "Klavika-Medium", size: 20)!, color: StyleManager.colors.redText, enableColor: .white)
                    }
                    if studentEducationItem.education101iotNum == 3 && Education == .iot {
                        text1 = "Bu eğitim üçüncü tercihinde bulunmaktadır. Eğitim kilidini açmak için Inovasyon 101 eğitimini tamamlayınız."
                        textView.attributedText = text1.setAttributedString(changeText: "üçüncü tercihinde", font: UIFont(name: "Klavika-Medium", size: 20)!, color: StyleManager.colors.redText, enableColor: .white)
                    }
                }
                
                if studentEducationItem.education101inoNum == 1 {
                    if studentEducationItem.education101aiNum == 2 && Education == .ai {
                        text1 = "Bu eğitim ikinci tercihinde bulunmaktadır. Eğitim kilidini açmak için İnovasyon 101 eğitimini tamamlayınız."
                        textView.attributedText = text1.setAttributedString(changeText: "ikinci tercihinde", font: UIFont(name: "Klavika-Medium", size: 20)!, color: StyleManager.colors.redText, enableColor: .white)
                    }
                    if studentEducationItem.education101aiNum == 3 && Education == .ai {
                        text1 = "Bu eğitim üçüncü tercihinde bulunmaktadır. Eğitim kilidini açmak için IoT 101 eğitimini tamamlayınız."
                        textView.attributedText = text1.setAttributedString(changeText: "üçüncü tercihinde", font: UIFont(name: "Klavika-Medium", size: 20)!, color: StyleManager.colors.redText, enableColor: .white)
                    }
                    if studentEducationItem.education101iotNum == 2 && Education == .iot {
                        text1 = "Bu eğitim ikinci tercihinde bulunmaktadır. Eğitim kilidini açmak için İnovasyon 101 eğitimini tamamlayınız."
                        textView.attributedText = text1.setAttributedString(changeText: "ikinci tercihinde", font: UIFont(name: "Klavika-Medium", size: 20)!, color: StyleManager.colors.redText, enableColor: .white)
                    }
                    if studentEducationItem.education101iotNum == 3 && Education == .iot {
                        text1 = "Bu eğitim üçüncü tercihinde bulunmaktadır. Eğitim kilidini açmak için Yapay Zeka 101 eğitimini tamamlayınız."
                        textView.attributedText = text1.setAttributedString(changeText: "üçüncü tercihinde", font: UIFont(name: "Klavika-Medium", size: 20)!, color: StyleManager.colors.redText, enableColor: .white)
                    }
                }
                
                if studentEducationItem.education101iotNum == 1 {
                    if studentEducationItem.education101aiNum == 2 && Education == .ai {
                        text1 = "Bu eğitim ikinci tercihinde bulunmaktadır. Eğitim kilidini açmak için IoT 101 eğitimini tamamlayınız."
                        textView.attributedText = text1.setAttributedString(changeText: "ikinci tercihinde", font: UIFont(name: "Klavika-Medium", size: 20)!, color: StyleManager.colors.redText, enableColor: .white)
                    }
                    if studentEducationItem.education101aiNum == 3 && Education == .ai {
                        text1 = "Bu eğitim üçüncü tercihinde bulunmaktadır. Eğitim kilidini açmak için İnovasyon 101 eğitimini tamamlayınız."
                        textView.attributedText = text1.setAttributedString(changeText: "üçüncü tercihinde", font: UIFont(name: "Klavika-Medium", size: 20)!, color: StyleManager.colors.redText, enableColor: .white)
                    }
                    if studentEducationItem.education101inoNum == 2 && Education == .inovation {
                        text1 = "Bu eğitim ikinci tercihinde bulunmaktadır. Eğitim kilidini açmak için IoT 101 eğitimini tamamlayınız."
                        textView.attributedText = text1.setAttributedString(changeText: "ikinci tercihinde", font: UIFont(name: "Klavika-Medium", size: 20)!, color: StyleManager.colors.redText, enableColor: .white)
                    }
                    if studentEducationItem.education101inoNum == 3 && Education == .inovation {
                        text1 = "Bu eğitim üçüncü tercihinde bulunmaktadır. Eğitim kilidini açmak için Yapay Zeka 101 eğitimini tamamlayınız."
                        textView.attributedText = text1.setAttributedString(changeText: "üçüncü tercihinde", font: UIFont(name: "Klavika-Medium", size: 20)!, color: StyleManager.colors.redText, enableColor: .white)
                    }
                }
            }
        } else {
            lockButtonView.isHidden = true
            textView.isHidden = true
            lockScreenView.isHidden = true
            lockScreenImageView.isHidden = true
        }
        switch Education {
        case .inovation:
            horizontalView.isHidden = inoHidden
            coverPhoto.image = UIImage(named: "Education/inovation101cover")
            if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey) {
                if let userItem = UserProvider.users(for: currentUserInfo) {
                    if userItem.userType == "Mentor" {
                        titleText.text = "MENTOR İNOVASYON EĞİTİMİ 101"
                    } else {
                        titleText.text = "İNOVASYON EĞİTİMİ 101"
                    }
                }
            }
            descLabel.text = "İnovasyonun önemini bilen, ancak hangi adımları atması gerektiği ve nereden başlayacağını bilmeyen öğrencilere yönelik hazırlamış olduğumuz müfredat ile öğrencilerin inovasyon farkındalığını ve bilgi düzeyini arttırmayı hedefliyoruz."
        case .iot:
            horizontalView.isHidden = iotHidden
            coverPhoto.image = UIImage(named: "Education/iot101cover")
            if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey) {
                if let userItem = UserProvider.users(for: currentUserInfo) {
                    if userItem.userType == "Mentor" {
                        titleText.text = "MENTOR IOT EĞİTİMİ 101"
                    } else {
                        titleText.text = "IOT EĞİTİMİ 101"
                    }
                }
            }
            descLabel.text = "Her geçen gün çevremizde ki cihazların hayatımızın daha çok içinde yer alması, yakın geleceğin akıllı cihazlar üzerine kurulacağının bir kanıtıdır. Bu eğitimde çevresini algılayan temel düzeyde karar veren ve iletişim halinde olan donanımların nasıl hayata geçtiğinin öğrenilmesi hedeflenmektedir."
        case .ai:
            horizontalView.isHidden = aiHidden
            coverPhoto.image = UIImage(named: "Education/ai101cover")
            if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey) {
                if let userItem = UserProvider.users(for: currentUserInfo) {
                    if userItem.userType == "Mentor" {
                        titleText.text = "MENTOR YAPAY ZEKA EĞİTİMİ 101"
                    } else {
                        titleText.text = "YAPAY ZEKA EĞİTİMİ 101"
                    }
                }
            }
            descLabel.text = "Lise öğrencilerinin temel robotik eğitim ve yapay zeka seviyesine ulaşmaları, bu eğitim sayesinde makine ve derin öğrenme çalışmaları yapmaları ve gerçek hayatta uygulamaları hedeflenmektedir."
        default:
            coverPhoto.image = UIImage(named: "Education/inovation101cover")
            if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey) {
                if let userItem = UserProvider.users(for: currentUserInfo) {
                    if userItem.userType == "Mentor" {
                        titleText.text = "MENTOR İNOVASYON EĞİTİMİ 101"
                    } else {
                        titleText.text = "İNOVASYON EĞİTİMİ 101"
                    }
                }
            }
            descLabel.text = "İnovasyonun önemini bilen, ancak hangi adımları atması gerektiği ve nereden başlayacağını bilmeyen öğrencilere yönelik hazırlamış olduğumuz müfredat ile öğrencilerin inovasyon farkındalığını ve bilgi düzeyini arttırmayı hedefliyoruz."
        }
        
        educationTableView.reloadData()
    }
    
    func initTableView()  {
        educationTableView.backgroundColor = StyleManager.colors.white
        educationTableView.delegate = self
        educationTableView.dataSource = self
        educationTableView.separatorStyle = .none
        self.educationTableView.register(UINib(nibName: "EducationsCell", bundle: nil), forCellReuseIdentifier: "EducationsCell")
    }
    
    @IBAction func tappedLockButton(_ sender: Any) {
        LyieLog.mPrint("readButtonTapped")
        self.alertTapAction!(self)
    }
    @IBAction func numberButtonTapped(_ sender: Any) {
        LyieLog.mPrint("tapped")
        self.navigateNumberTapAction!(self)
    }
}

//MARK:  - UITableViewDelegate, UITableViewDataSource
extension Education101Cell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EducationChildCoursesProvider.educationChildCourses().filter({ $0.mainEducation == educationStep.rawValue }).filter({ $0.mainEducationValue == 101 }).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EducationsCell = tableView.dequeueReusableCell(at: indexPath) as EducationsCell
        if profileUpdate {
            cell.selectionStyle = .none
        } else {
            cell.selectionStyle = .gray
        }
        cell.configDetail(Education: educationStep, CellNumber: indexPath.row, goalData: 100, percentViewActive: !profileUpdate, lockIconHidden: !lockActive, completed: false, isProfile: profileUpdate)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if profileUpdate {
            return 125.0
        } else {
            return 130.0
        }
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if lockActive != false {
            self.alertTapAction!(self)
        } else {
            if !profileUpdate {
                limitedFunc(indexPath: indexPath)
            }
            
            if isMentorUpdate {
                limitedFunc(indexPath: indexPath)
            }
            
        }
        LyieLog.mPrint("tapped")
    }
    
    func limitedFunc(indexPath: IndexPath) {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                if (education.rawValue == "Inovation") {
                    
                    studentEducationItem.questionAreaCell = indexPath.row
                    StudentEducationProvider.update(studentEducations: studentEducationItem)
                    
                    LyieUtils.updateUserEducationProgress(userEducationProgress: UserEducationProgressInfo(objectId:  PFUser.current()?.objectId ?? "", userID: PFUser.current()?.username ?? "", education101iotNum: studentEducationItem.education101iotNum, education101aiNum: studentEducationItem.education101aiNum, education101inoNum: studentEducationItem.education101inoNum, mainEducation: studentEducationItem.mainEducation, mainEducationValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum, currentEducationNum: studentEducationItem.currentEducationNum, currentEducationsCount: LyieUtils.objectCountValue(), currentCell: studentEducationItem.currentCell, questionAreaCell: studentEducationItem.questionAreaCell, questionAreaMainEdu: studentEducationItem.mainEducation, questionAreaMainValue: studentEducationItem.mainEducationValue))
                }
            }
        }
        
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            if studentEducationItem.currentEducationNum != 0 {
                if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                    if (education.rawValue == "Inovation") {
                        index = studentEducationItem.mainEducationCellNum
                        if indexPath.row > index {
                            LyieLog.mPrint("pagepage")
                            self.alertTapAction!(self)
                        } else {
                            self.navigateTapAction!(self)
                        }
                    } else {
                        self.navigateTapAction!(self)
                    }
                } else {
                    self.navigateTapAction!(self)
                }
            } else {
                index = studentEducationItem.mainEducationCellNum
                if indexPath.row > index {
                    LyieLog.mPrint("pagepage")
                    self.alertTapAction!(self)
                } else {
                    self.navigateTapAction!(self)
                }
            }
        } else {
            self.navigateTapAction!(self)
        }
    }
}
