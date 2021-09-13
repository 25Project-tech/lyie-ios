//
//  QuestionCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 1.04.2021.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    static let reuseIdentifier = "QuestionCell"
    
    @IBOutlet weak var leftTitleView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var mainEducationView: UIView!
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet var allButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var questionArea: UIView!
    
    var tappedLeftButton: ((QuestionCell) -> ())?
    var tappedRightButton: ((QuestionCell) -> ())?
    
    func config(titleString: String, desc: String, imageName: String, isHidden: Bool, horizontalViewIsHidden: Bool, count: Int, indexRow: Int, videoUrl: String, cellId: Int, leftButtonValue: Bool, rightButtonValue: Bool, leftButtonText: String, rightButtonText: String) {
        titleText.text = titleString
        descLabel.text = desc
        allButton.setTitle("Devam Et", for: .normal)
        buttonView.cornerRadius = 10.0
        horizontalView.isHidden = horizontalViewIsHidden
        leftButton.setTitle(leftButtonText, for: .normal)
        leftButton.backgroundColor = UIColor.gray
        rightButton.setTitle(rightButtonText, for: .normal)
        rightButton.backgroundColor = UIColor.gray
        config()
    }
    
    func config(titleString: String, desc: String, imageName: String, isHidden: Bool, horizontalViewIsHidden: Bool, count: Int, indexRow: Int, videoUrl: String, cellId: Int, leftButtonValue: Bool, rightButtonValue: Bool, leftButtonText: String, rightButtonText: String, leftButtonColor: UIColor, rightButtonColor: UIColor) {
        config(titleString: titleString, desc: desc, imageName: imageName, isHidden: isHidden, horizontalViewIsHidden: horizontalViewIsHidden, count: count, indexRow: indexRow, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftButtonValue, rightButtonValue: rightButtonValue, leftButtonText: leftButtonText, rightButtonText: rightButtonText)
        if leftButtonColor == UIColor.green {
            leftButton.borderColor = UIColor.green
        } else {
            rightButton.borderColor = UIColor.green
        }
        leftButton.backgroundColor = leftButtonColor
        rightButton.backgroundColor = rightButtonColor
    }
    
    func config() {
        mainEducationView.makeShadow()
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.textColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        allButton.backgroundColor = StyleManager.colors.leftTitleColor
        allButton.cornerRadius = 10.0
        buttonView.isHidden = true
        rightButton.borderColor = StyleManager.colors.lightGray
        rightButton.borderWidth = 1.0
        leftButton.borderColor = StyleManager.colors.lightGray
        leftButton.borderWidth = 1.0
    }
    
    @IBAction func tappedLeftButton(_ sender: Any) {
        LyieLog.mPrint("tappedOnAll")
        self.tappedLeftButton!(self)
    }
    @IBAction func tappedRightButton(_ sender: Any) {
        LyieLog.mPrint("tappedOnAll")
        self.tappedRightButton!(self)
    }
}
