//
//  SpecificQuestionAreaCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.01.2021.
//

import UIKit
import Parse

class SpecificQuestionAreaCell: UITableViewCell, QuestionObserver {
    
    static let reuseIdentifier = "SpecificQuestionAreaCell"
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var emptyQuestionArea: UILabel!
    @IBOutlet weak var questionCell: UIView!
    
    var alertTapAns: ((SpecificQuestionAreaCell) -> ())?
    var alertTapQues: ((SpecificQuestionAreaCell) -> ())?
    var mainEducation = ""
    var mainEducationValue = 0
    var mainEducationCellValue = 0
    
    func config(education: String, educationValue: Int, educationCell: Int) {
        mainEducation = education
        mainEducationValue = educationValue
        mainEducationCellValue = educationCell
        
        myTableView.dataSource = self
        myTableView.delegate = self
        mainView.makeShadow()
        leftView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = "İnovasyon 101 Bölüm 1 Soru Alanı"
        titleText.textColor = StyleManager.colors.leftTitleColor
        myTableView.register(UINib(nibName: "LeftQuestionTypeCell", bundle: nil), forCellReuseIdentifier: "LeftQuestionTypeCell")
        myTableView.backgroundColor = .white
        
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            if QuestionProvider.questions().filter({ $0.mainEducation == "Inovation"}).filter({ $0.mainEducationValue == 101}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).count == 0 {
                emptyQuestionArea.text = "Herhangi soru bulunmamaktadır."
                emptyQuestionArea.textColor = .black
            } else {
                emptyQuestionArea.isHidden = true
            }
        }
    }
    
    func onDidChange(questions: [QuestionItem]) {
        myTableView.reloadData()
    }
    
    
    @IBAction func tappedQuestionButton(_ sender: Any) {
        LyieLog.mPrint("questionTapped")
        self.alertTapQues!(self)        
    }
}

extension SpecificQuestionAreaCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            return QuestionProvider.questions().filter({ $0.mainEducation == "Inovation"}).filter({ $0.mainEducationValue == 101}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LeftQuestionTypeCell = tableView.dequeueReusableCell(at: indexPath)
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            let questions = QuestionProvider.questions().filter({ $0.mainEducation == "Inovation"}).filter({ $0.mainEducationValue == 101}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell})
            if questions.count == 0 {
                emptyQuestionArea.text = "Herhangi soru bulunmamaktadır."
                emptyQuestionArea.textColor = .black
            } else {
                if let user = UserDefaults.standard.string(forKey: currentUserKey), let userItem = UserProvider.users(for: user) {
                    cell.config(quesUser:  questions[indexPath.row].userID, ques: questions[indexPath.row].question, buttonHidden: false, userPhoto: questions[indexPath.row].userPhotoURL)
                } else {
                    cell.config(quesUser: "", ques: "", buttonHidden: true, userPhoto: "")
                }
            }
        }
        
        cell.alertTapAction = { cell in
            self.alertTapAns!(self)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190.0
    }
    
}
