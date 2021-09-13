//
//  MessageAreaCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 16.01.2021.
//

import UIKit

class MessageAreaCell: UITableViewCell, UITextViewDelegate {
    static let reuseIdentifier = "MessageAreaCell"
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var textViewArea: UIView!
    @IBOutlet weak var messageArea: UITextView!
    @IBOutlet weak var sendButton: UIView!
    @IBOutlet weak var sendButtonButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    
    var tappedWithSendButton: ((MessageAreaCell) -> ())?
    
    func config() {
        messageArea.delegate = self
        messageArea.clipsToBounds = true
        messageArea.flashScrollIndicators()
        mainView.makeShadow()
        leftView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = "MESAJ ALANI"
        descText.text = "Eğitimlerle ilgili özel bir soru - sorun veya tavsiyeniz varsa mentorlarına bu alandan iletebilirsin."
        titleText.textColor = StyleManager.colors.leftTitleColor
        textViewArea.makeShadow()
        textViewArea.backgroundColor = StyleManager.colors.backgroundColor
        messageArea.backgroundColor = StyleManager.colors.backgroundColor
        sendButton.backgroundColor = StyleManager.colors.leftTitleColor
        sendButtonButton.setTitle("Gönder", for: .normal)
        lineView.backgroundColor = StyleManager.colors.lineColor
    }
    
    @IBAction func tappedSendButton(_ sender: Any) {
        LyieLog.mPrint("fifthViewButtonTapped")
        
//        if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey), var currentUser = UserProvider.users(for: currentUserInfo) {
//            let currentQuestionItemCount = UserProvider.users(for: currentUserInfo)?.questionCount
//            
//            var questionItem = QuestionProvider.create(with: "\(currentQuestionItemCount!)")
//            questionItem.identifier = "\(currentQuestionItemCount!)"
//            questionItem.userID = UserProvider.users(for: currentUserInfo)!.userID
//            questionItem.question = messageArea.text
//            QuestionProvider.update(questions: questionItem)
//            
//            currentUser.questionCount = currentQuestionItemCount! + 1
//            UserProvider.update(users: currentUser)
//        }
        
        self.tappedWithSendButton!(self)
        messageArea.text = ""
        
    }
}
