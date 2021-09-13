//
//  RightQuestionTypeCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.01.2021.
//

import UIKit

class RightQuestionTypeCell: UITableViewCell {
    static let reuseIdentifier = "RightQuestionTypeCell"
    
    @IBOutlet weak var cellPhoto: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet var backgroundTopView: UIView!
    @IBOutlet var questionText: UILabel!
    @IBOutlet var buttonView: UIView!
    @IBOutlet var answerButton: UIButton!
    
    func config(quesUser: String, ques: String, buttonHidden: Bool) {
        cellTitle.textColor = StyleManager.colors.leftTitleColor
        mainView.backgroundColor = StyleManager.colors.questionArea
        cellTitle.text = quesUser
        mainView.makeShadow()
        cellPhoto.image = UIImage(named: "Profile/photo1")
        questionText.text = ques
        buttonView.backgroundColor = StyleManager.colors.leftTitleColor
        answerButton.setTitle("Yanıtla", for: .normal)
        buttonView.isHidden = buttonHidden
    }
    
    @IBAction func tappedAnswerButton(_ sender: Any) {
        
    }
}

