//
//  LeftQuestionTypeCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.01.2021.
//

import UIKit

class LeftQuestionTypeCell: UITableViewCell {
    static let reuseIdentifier = "LeftQuestionTypeCell"
    
    @IBOutlet weak var cellPhoto: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet var backgroundTopView: UIView!
    @IBOutlet var questionText: UILabel!
    @IBOutlet var buttonView: UIView!
    @IBOutlet var answerButton: UIButton!
    
    var alertTapAction: ((LeftQuestionTypeCell) -> ())?
    
    func config(quesUser: String, ques: String, buttonHidden: Bool, userPhoto: String) {
        cellTitle.textColor = StyleManager.colors.leftTitleColor
        mainView.backgroundColor = StyleManager.colors.questionArea
        cellTitle.text = quesUser
        mainView.makeShadow()
        LyieUtils.loadImage(resource: cellPhoto, imageURL: userPhoto, placeHolder: UIImage(named: "Profile/profile-1"), isCircle: false)
        questionText.text = ques
        buttonView.backgroundColor = StyleManager.colors.leftTitleColor
        answerButton.setTitle("Yanıtla", for: .normal)
        buttonView.isHidden = buttonHidden
    }
    
    @IBAction func tappedAnswerButton(_ sender: Any) {
        LyieLog.mPrint("tapped")
        self.alertTapAction!(self)
    }
}
