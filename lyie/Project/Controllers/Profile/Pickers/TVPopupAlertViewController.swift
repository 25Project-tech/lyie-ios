//
//  TVPopupAlertViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.02.2021.
//

import UIKit
import PopupDialog
import Parse

protocol TVDelegate {
    func onTVDismissed()
    func onChangeText(target: String)
    func onChangeText(ques: String)
    func onChangeText(ans: String)
}

class TVPopupAlertViewController: UIViewController, Localizable, UITextViewDelegate {
    
    @IBOutlet weak var profileValueLabel: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tvView: UIView!
    
    var userItem: UserItem?
    var selectedName = ""
    var popup: PopupDialog?
    var tvDelegate: TVDelegate!
    var textViewType: Int? //0 -> target
    var mainEducation = ""
    var mainEducationValue = 0
    var mainEducationCellNum = 0
    var totalScore = 0
    var scoreValue = 0
    func applyLanguage() {
        saveButton.setTitle("Kaydet", for: .normal)
        clearButton.setTitle("Sil", for: .normal)
        
        saveButton.backgroundColor = StyleManager.colors.leftTitleColor
        clearButton.backgroundColor = StyleManager.colors.leftTitleColor
        
        profileValueLabel.borderWidth = 1.0
        profileValueLabel.borderColor = .lightGray
        
        tvView.borderColor = StyleManager.colors.borderColorBlue
        profileValueLabel.borderWidth = 0
        
        
        switch textViewType {
        case 0:
            titleLabel.text = "Amaç"
            profileValueLabel.keyboardType = .alphabet
        case 1:
            titleLabel.text = "Sorunuz"
            profileValueLabel.keyboardType = .alphabet
        case 2:
            titleLabel.text = "Cevabınız"
            profileValueLabel.keyboardType = .alphabet
        default:
            titleLabel.text = ""
        }
    }
    
    @IBAction func saveTF(_ sender: Any) {
        if profileValueLabel.text != "" {
            if textViewType == 0 {
                tvDelegate.onChangeText(target: profileValueLabel.text!.removingLeadingSpaces())
            } else if textViewType == 1 {
                if let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user), let studentEducationItem = StudentEducationProvider.studentEducations(for: user), let infos = HomeMentorProvider.mentors(for: user) {
                    if let currentUser = PFUser.current() {
                        let questionInfoObject = PFObject(className: "QuestionArea")
                        questionInfoObject["userID"] = currentUser.username
                        questionInfoObject["classID"] = userItem.classID
                        questionInfoObject["questionDesc"] = self.profileValueLabel.text
                        questionInfoObject["mainEducation"] = "Inovation"
                        questionInfoObject["mainEducationValue"] = 101
                        questionInfoObject["mainEducationCellNum"] = studentEducationItem.questionAreaCell
                        questionInfoObject["answerQuestionID"] = ""
                        questionInfoObject["userProfileURL"] = infos.userImageURL
                        questionInfoObject.saveInBackground { (success, error) in
                            if error != nil {
                                print(error?.localizedDescription)
                            } else {
                                print("success")
                                let questionTitle = EducationChildCoursesProvider.educationChildCourses().filter({ $0.mainEducation == "Inovation" }).filter({ $0.mainEducationValue == 101 }).filter({ $0.mainEducationCellNumber == studentEducationItem.questionAreaCell })[0].title
                                let query = PFQuery(className: "UserScoreInfo")
                                query.countObjectsInBackground { (count, error) in
                                    if count != 0 {
                                        query.whereKey("totalScore", greaterThan: 0)
                                        query.findObjectsInBackground { (objects, error) in
                                            if let objects = objects {
                                                if objects.count > 0 {
                                                    if objects.last!["totalScore"] != nil {
                                                        self.totalScore = objects.last!["totalScore"] as! Int
                                                        LyieUtils.scoreDetailPart(scoreDetail: UserScoreModel(objectId: currentUser.objectId ?? "", userID: currentUser.username!, scoreDesc: "Inovation - 101 - \(questionTitle) ile ilgili mentore soru soruldu.", scoreValue: 100, totalScore: self.totalScore + 100))
                                                        self.createdRealmObj()
                                                    } else {
                                                        LyieUtils.scoreDetailPart(scoreDetail: UserScoreModel(objectId: currentUser.objectId ?? "", userID: currentUser.username!, scoreDesc: "Inovation - 101 - \(questionTitle) ile ilgili mentore soru soruldu.", scoreValue: 100, totalScore: 100))
                                                        self.createdRealmObj()
                                                    }
                                                } else {
                                                    LyieUtils.scoreDetailPart(scoreDetail: UserScoreModel(objectId: currentUser.objectId ?? "", userID: currentUser.username!, scoreDesc: "Inovation - 101 - - \(questionTitle) ile ilgili mentore soru soruldu.", scoreValue: 100, totalScore: 100))
                                                    self.createdRealmObj()
                                                }
                                            }
                                        }
                                    } else {
                                        LyieUtils.scoreDetailPart(scoreDetail: UserScoreModel(objectId: currentUser.objectId ?? "", userID: currentUser.username!, scoreDesc: "Inovation - 101 - \(questionTitle) ile ilgili mentore soru soruldu.", scoreValue: 100, totalScore: 100))
                                        self.createdRealmObj()
                                    }
                                }
                            }
                        }
                    }
                }
                tvDelegate.onChangeText(ques: profileValueLabel.text!.removingLeadingSpaces())
            } else {
                if let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user), let studentEducationItem = StudentEducationProvider.studentEducations(for: user), let infos = HomeMentorProvider.mentors(for: user) {
                    if let currentUser = PFUser.current() {
                        let questionInfoObject = PFObject(className: "QuestionArea")
                        questionInfoObject["userID"] = currentUser.username
                        questionInfoObject["classID"] = userItem.classID
                        questionInfoObject["questionDesc"] = profileValueLabel.text
                        questionInfoObject["mainEducation"] = "Inovation"
                        questionInfoObject["mainEducationValue"] = 101
                        questionInfoObject["mainEducationCellNum"] = studentEducationItem.questionAreaCell
                        questionInfoObject["answerQuestionID"] = ""
                        questionInfoObject["userProfileURL"] = infos.userImageURL
                        questionInfoObject.saveInBackground { (success, error) in
                            if error != nil {
                                print(error?.localizedDescription)
                            } else {
                                print("success")
                                self.scoreValue = 100
                                let questionAnswer = EducationChildCoursesProvider.educationChildCourses().filter({ $0.mainEducation == self.mainEducation }).filter({ $0.mainEducationValue == self.mainEducationValue }).filter({ $0.mainEducationCellNumber == self.mainEducationCellNum })[0].title
                                if let currentUser = PFUser.current() {
                                    let query = PFQuery(className: "UserScoreInfo")
                                    query.countObjectsInBackground { (count, error) in
                                        if count != 0 {
                                            query.whereKey("totalScore", greaterThan: 0)
                                            query.findObjectsInBackground { (objects, error) in
                                                if let objects = objects {
                                                    if objects.count > 0 {
                                                        if objects.last!["totalScore"] != nil {
                                                            self.totalScore = objects.last!["totalScore"] as! Int
                                                            LyieUtils.scoreDetailPart(scoreDetail: UserScoreModel(objectId: currentUser.objectId ?? "", userID: currentUser.username!, scoreDesc: "Inovation - 101 - \(questionAnswer) ile ilgili soruya cevap verildi.", scoreValue: 100, totalScore: self.totalScore + 100))
                                                            self.createdRealmObj()
                                                        } else {
                                                            LyieUtils.scoreDetailPart(scoreDetail: UserScoreModel(objectId: currentUser.objectId ?? "", userID: currentUser.username!, scoreDesc: "Inovation - 101 - \(questionAnswer) ile ilgili soruya cevap verildi.", scoreValue: 100, totalScore: 100))
                                                            self.createdRealmObj()
                                                        }
                                                    } else {
                                                        LyieUtils.scoreDetailPart(scoreDetail: UserScoreModel(objectId: currentUser.objectId ?? "", userID: currentUser.username!, scoreDesc: "Inovation - 101 - \(questionAnswer) ile ilgili soruya cevap verildi.", scoreValue: 100, totalScore: 100))
                                                        self.createdRealmObj()
                                                    }
                                                }
                                            }
                                        } else {
                                            LyieUtils.scoreDetailPart(scoreDetail: UserScoreModel(objectId: currentUser.objectId ?? "", userID: currentUser.username!, scoreDesc: "Inovation - 101 - \(questionAnswer) ile ilgili soruya cevap verildi.", scoreValue: 100, totalScore: 100))
                                            self.createdRealmObj()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                tvDelegate.onChangeText(ans: profileValueLabel.text!.removingLeadingSpaces())
            }
        }
        tvDelegate.onTVDismissed()
    }
    
    @IBAction func clearTF(_ sender: Any) {
        if profileValueLabel.text != "" {
            if textViewType! == 0 {
                tvDelegate.onChangeText(target: "")
            } else if textViewType! == 1 {
                tvDelegate.onChangeText(ques: "")
            } else {
                tvDelegate.onChangeText(ans: "")
            }
        }
        tvDelegate.onTVDismissed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingLanguage()
        profileValueLabel.backgroundColor = .white
        fillData()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc func endEditing() {
        view.endEditing(true)
    }

    
    @IBAction func cancel(_ sender: Any) {
        tvDelegate.onTVDismissed()
    }
    
    func createdRealmObj() {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) {
            let questionObject = PFQuery(className: "QuestionArea")
            questionObject.whereKey("classID", equalTo: userItem.classID)
            questionObject.findObjectsInBackground { (objc, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    if let objc = objc {
                        if QuestionProvider.questions().count != objc.count {
                            QuestionNotifier.shared.removeAll()
                            
                            for i in 0..<objc.count {
                                QuestionProvider.create(with: "\(i)")
                                if var questionItem = QuestionProvider.questions(for: "\(i)") {
                                    questionItem.mainEducationValue = objc[i]["mainEducationValue"] as? Int ?? 0
                                    questionItem.userID = objc[i]["userID"] as? String ?? ""
                                    questionItem.mainEducation = objc[i]["mainEducation"] as? String ?? ""
                                    questionItem.mainEducationCellNum = objc[i]["mainEducationCellNum"] as? Int ?? 0
                                    questionItem.question = objc[i]["questionDesc"] as? String ?? ""
                                    questionItem.userPhotoURL = objc[i]["userProfileURL"] as? String ?? ""
                                    QuestionProvider.update(questions: questionItem)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}

extension TVPopupAlertViewController {
    fileprivate func fillData() {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), let userItem = UserProvider.users(for: user) else {
            return
        }
        
        if textViewType == 0 {
            profileValueLabel.text = userItem.targetString
        } else if textViewType == 1 {
            profileValueLabel.text = ""
        } else {
            profileValueLabel.text = ""
        }
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        return profileValueLabel.text.
//    }
}
