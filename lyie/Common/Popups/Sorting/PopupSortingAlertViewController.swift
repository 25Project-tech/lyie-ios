//
//  PopupSortingAlertViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 22.12.2020.
//

import UIKit
import Parse

class PopupSortingAlertViewController: UIViewController {
    
    @IBOutlet weak var alertBackView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var firstNumberView: UIView!
    @IBOutlet weak var secondNumberView: UIView!
    @IBOutlet weak var thirdNumberView: UIView!
    
    var delegate: AlertPopupViewDelegate!
    var educationType: Int? //0 -> boş // 1 -> ino // 2 -> iot // 3 -> ai
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func config(alert: AlertPopupView) {
        
        firstNumberView.borderColor = StyleManager.colors.borderColorBlue
        firstNumberView.borderWidth = 1.0
        secondNumberView.borderWidth = 1.0
        secondNumberView.borderColor = StyleManager.colors.borderColorBlue
        thirdNumberView.borderColor = StyleManager.colors.borderColorBlue
        thirdNumberView.borderWidth = 1.0
        alertBackView.cornerRadius = 23
        
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            if studentEducationItem.education101aiNum == 1 || studentEducationItem.education101inoNum == 1 || studentEducationItem.education101iotNum == 1 {
                self.firstNumberView.isHidden = true
            } else {
                self.firstNumberView.isHidden = false
            }
            
            if studentEducationItem.education101aiNum == 2 || studentEducationItem.education101inoNum == 2 || studentEducationItem.education101iotNum == 2 {
                self.secondNumberView.isHidden = true
            } else {
                self.secondNumberView.isHidden = false
            }
            
            if studentEducationItem.education101aiNum == 3 || studentEducationItem.education101inoNum == 3 || studentEducationItem.education101iotNum == 3 {
                self.thirdNumberView.isHidden = true
            } else {
                self.thirdNumberView.isHidden = false
            }
        }
        
        self.cancelBtn.setTitle(alert.cancelBtnTitle, for: UIControl.State.normal)
        self.acceptBtn.setTitle(alert.acceptBtnTitel, for: UIControl.State.normal)
        
        self.alertBackView.backgroundColor = alert.alertBackViewColor
        self.acceptBtn.backgroundColor = alert.acceptBtnBackColor
        self.cancelBtn.backgroundColor = alert.cancelBtnBackColor
    }
    
    
    @IBAction func secondNumberTapped(_ sender: Any) {
        var objectCount = 0
        if let currentUser = PFUser.current() {
            let query = PFQuery(className: "EducationMainLessons")
            query.whereKey("mainEducation", equalTo: "Inovation")
            query.findObjectsInBackground { (objects, error) in
                if let objects = objects {
                    for object in objects {
                        if object.object(forKey: "mainEducationValue") != nil && object.object(forKey: "mainEducationCellNum") != nil {
                            if object.object(forKey: "mainEducationValue") as! Int == 101 {
                                if object.object(forKey: "mainEducationCellNum") as! Int == 0 {
                                    objectCount = objectCount + 1
                                }
                            }
                        }
                    }
                    
                    if let user = UserDefaults.standard.string(forKey: currentUserKey), var studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                        switch self.educationType {
                        case 1:
                            studentEducationItem.education101inoNum = 2
                        case 2:
                            studentEducationItem.education101iotNum = 2
                        case 3:
                            studentEducationItem.education101aiNum = 2
                        default:
                            LyieLog.mPrint("default")
                        }
                        
                        studentEducationItem.education101inoNum = 1
                        studentEducationItem.mainEducation = "Inovation"
                        studentEducationItem.mainEducationValue = 101
                        studentEducationItem.mainEducationCellNum = 0
                        studentEducationItem.currentEducationNum = 0
                        
                        if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                            let arrayCount = EducationServices.getList(by: education.rawValue, mainEduValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum).count
                            studentEducationItem.currentEducationsCount = arrayCount
                        }
                        
                        StudentEducationProvider.update(studentEducations: studentEducationItem)
                        
                        LyieUtils.updateUserEducationProgress(userEducationProgress: UserEducationProgressInfo(objectId: currentUser.objectId ?? "", userID: currentUser.username ?? "", education101iotNum: studentEducationItem.education101iotNum, education101aiNum: studentEducationItem.education101aiNum, education101inoNum: studentEducationItem.education101inoNum, mainEducation: "Inovation", mainEducationValue: 101, mainEducationCellNum: 0, currentEducationNum: 0, currentEducationsCount: objectCount, currentCell: 0, questionAreaCell: 0, questionAreaMainEdu: "Inovation", questionAreaMainValue: 101))
                    }
                    objectCount = 0
                }
            }
        }
        
        delegate.secondTapped()
    }
    
    @IBAction func firstNumberTapped(_ sender: Any) {
        delegate.firstTapped()
        var objectCount = 0
        if let currentUser = PFUser.current() {
            let query = PFQuery(className: "EducationMainLessons")
            query.whereKey("mainEducation", equalTo: "Inovation")
            query.findObjectsInBackground { (objects, error) in
                if let objects = objects {
                    for object in objects {
                        if object.object(forKey: "mainEducationValue") != nil && object.object(forKey: "mainEducationCellNum") != nil {
                            if object.object(forKey: "mainEducationValue") as! Int == 101 {
                                if object.object(forKey: "mainEducationCellNum") as! Int == 0 {
                                    objectCount = objectCount + 1
                                }
                            }
                        }
                    }
                    
                    if let user = UserDefaults.standard.string(forKey: currentUserKey), var studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                        switch self.educationType {
                        case 1:
                            studentEducationItem.education101inoNum = 1
                            studentEducationItem.mainEducation = "Inovation"
                            studentEducationItem.mainEducationValue = 101
                            studentEducationItem.mainEducationCellNum = 0
                            studentEducationItem.currentEducationNum = 0
                            if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                                let arrayCount = EducationServices.getList(by: education.rawValue, mainEduValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum).count
                                studentEducationItem.currentEducationsCount = arrayCount
                            }
                            
                        case 2:
                            studentEducationItem.education101iotNum = 1
                            studentEducationItem.mainEducation = "Iot"
                            studentEducationItem.mainEducationValue = 101
                            studentEducationItem.mainEducationCellNum = 0
                            studentEducationItem.currentEducationNum = 0
                            if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                                let arrayCount = EducationServices.getList(by: education.rawValue, mainEduValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum).count
                                studentEducationItem.currentEducationsCount = arrayCount
                            }
                        case 3:
                            studentEducationItem.education101aiNum = 1
                            studentEducationItem.mainEducation = "Ai"
                            studentEducationItem.mainEducationValue = 101
                            studentEducationItem.mainEducationCellNum = 0
                            studentEducationItem.currentEducationNum = 0
                            if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                                let arrayCount = EducationServices.getList(by: education.rawValue, mainEduValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum).count
                                studentEducationItem.currentEducationsCount = arrayCount
                            }
                        default:
                            LyieLog.mPrint("default")
                        }
                        studentEducationItem.mainEducation = "Inovation"
                        StudentEducationProvider.update(studentEducations: studentEducationItem)
                        
                        LyieUtils.updateUserEducationProgress(userEducationProgress: UserEducationProgressInfo(objectId: currentUser.objectId ?? "", userID: currentUser.username ?? "", education101iotNum: studentEducationItem.education101iotNum, education101aiNum: studentEducationItem.education101aiNum, education101inoNum: studentEducationItem.education101inoNum, mainEducation: "Inovation", mainEducationValue: 101, mainEducationCellNum: 0, currentEducationNum: 0, currentEducationsCount: objectCount, currentCell: 0, questionAreaCell: 0, questionAreaMainEdu: "Inovation", questionAreaMainValue: 101))
                    }
                    objectCount = 0
                }
            }
        }
    }
    
    @IBAction func thirdNumberTapped(_ sender: Any) {
        delegate.thirdTapped()
        var objectCount = 0
        if let currentUser = PFUser.current() {
            let query = PFQuery(className: "EducationMainLessons")
            query.whereKey("mainEducation", equalTo: "Inovation")
            query.findObjectsInBackground { (objects, error) in
                if let objects = objects {
                    for object in objects {
                        if object.object(forKey: "mainEducationValue") != nil && object.object(forKey: "mainEducationCellNum") != nil {
                            if object.object(forKey: "mainEducationValue") as! Int == 101 {
                                if object.object(forKey: "mainEducationCellNum") as! Int == 0 {
                                    objectCount = objectCount + 1
                                }
                            }
                        }
                    }
                    
                    if let user = UserDefaults.standard.string(forKey: currentUserKey), var studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                        switch self.educationType {
                        case 1:
                            studentEducationItem.education101inoNum = 3
                        case 2:
                            studentEducationItem.education101iotNum = 3
                        case 3:
                            studentEducationItem.education101aiNum = 3
                        default:
                            LyieLog.mPrint("default")
                        }
                        studentEducationItem.education101inoNum = 1
                        studentEducationItem.mainEducation = "Inovation"
                        studentEducationItem.mainEducationValue = 101
                        studentEducationItem.mainEducationCellNum = 0
                        studentEducationItem.currentEducationNum = 0
                        if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                            let arrayCount = EducationServices.getList(by: education.rawValue, mainEduValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum).count
                            studentEducationItem.currentEducationsCount = arrayCount
                        }
                        
                        StudentEducationProvider.update(studentEducations: studentEducationItem)
                        
                        LyieUtils.updateUserEducationProgress(userEducationProgress: UserEducationProgressInfo(objectId: currentUser.objectId ?? "", userID: currentUser.username ?? "", education101iotNum: studentEducationItem.education101iotNum, education101aiNum: studentEducationItem.education101aiNum, education101inoNum: studentEducationItem.education101inoNum, mainEducation: "Inovation", mainEducationValue: 101, mainEducationCellNum: 0, currentEducationNum: 0, currentEducationsCount: objectCount, currentCell: 0, questionAreaCell: 0, questionAreaMainEdu: "Inovation", questionAreaMainValue: 101))
                    }
                    objectCount = 0
                }
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate.alertCancel()
    }
    
    @IBAction func accept(_ sender: Any) {
        delegate.alertAccept()
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        delegate.closeTapped()
    }
}

extension PopupSortingAlertViewController {
    func updateCells () {
        LyieUtils.cancelInfoUserEducationProgress()
    }
}

