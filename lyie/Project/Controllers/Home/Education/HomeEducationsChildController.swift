//
//  HomeEducationsChildController.swift
//  lyie
//
//  Created by Sevcan Eşim on 29.11.2020.
//

import UIKit

protocol PopupDelegate {
    func alertView()
}

class HomeEducationsChildController: UIViewController {

    @IBOutlet var educationTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    
    var index = 0
    var alertDelegate: PopupDelegate!
    var isMentor = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingStudentEducations()
        config()
    }
    
    func config() {
        educationTableView.delegate = self
        educationTableView.dataSource = self
        self.educationTableView.register(UINib(nibName: "Education101Cell", bundle: nil), forCellReuseIdentifier: "Education101Cell")
        educationTableView.separatorStyle = .none
        educationTableView.backgroundColor = StyleManager.colors.backgroundColor
        mainView.backgroundColor = StyleManager.colors.backgroundColor
    }
    
    func warning() {
        self.UI {
            AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: "Henüz yüklenmedi.", desc: "Bölümü tamamlamanız için öncelikli eğitiminizi tamamlayın. ", vc: self)
        }
    }
}

extension HomeEducationsChildController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Education101Cell = tableView.dequeueReusableCell(at: indexPath)
        cell.selectionStyle = .none
        cell.alertTapAction = { cell in
            self.warning()
        }
        
        cell.navigateTapAction = { cell in
            self.alertDelegate.alertView()
        }
        
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            if index == studentEducationItem.education101inoNum - 1 {
                if index != 0 {
                    cell.config(Education: .inovation, inoHidden: true, iotHidden: true, aiHidden: true, numberViewHidden: true, lockScreen: true, isProfileUpdate: false, isMentorUpdate: isMentor)
                } else {
                    cell.config(Education: .inovation, inoHidden: true, iotHidden: true, aiHidden: true, numberViewHidden: true, lockScreen: false, isProfileUpdate: false, isMentorUpdate: isMentor)
                }
                
            } else if index == studentEducationItem.education101iotNum - 1 {
                if index != 0 {
                    cell.config(Education: .iot, inoHidden: true, iotHidden: true, aiHidden: true, numberViewHidden: true, lockScreen: true, isProfileUpdate: false, isMentorUpdate: isMentor)
                } else {
                    cell.config(Education: .iot, inoHidden: true, iotHidden: true, aiHidden: true, numberViewHidden: true, lockScreen: false, isProfileUpdate: false, isMentorUpdate: isMentor)
                }
                
            } else {
                if index != 0 {
                    cell.config(Education: .ai, inoHidden: true, iotHidden: true, aiHidden: true, numberViewHidden: true, lockScreen: true, isProfileUpdate: false, isMentorUpdate: isMentor)
                } else {
                    cell.config(Education: .ai, inoHidden: true, iotHidden: true, aiHidden: true, numberViewHidden: true, lockScreen: false, isProfileUpdate: false, isMentorUpdate: isMentor)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 610.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
//            if studentEducationItem.currentEducationNum != 0 {
//                if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
//                    if (education.rawValue == "Inovation") {
//                        index = studentEducationItem.mainEducationCellNum
//                        if indexPath.row > index {
//                            LyieLog.mPrint("pagepage")
//                            warning()
//                        }
//                    }
//                }
//            }
//        }
        if index != 0 {
            LyieLog.mPrint("pagepage")
            warning()
        }
    }
}

extension HomeEducationsChildController: StudentEducationObserver {
    func onDidChange(studentEducations: [StudentEducationItem]) {
        educationTableView.reloadData()
    }
}
