//
//  SignUpInfo.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.04.2021.
//

import UIKit
import PopupDialog

class SignUpInfo: UITableViewCell {
    static let reuseIdentifier = "SignUpInfo"
    
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet weak var leftTitleView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var secondLeftBlueIcon: UIView!
    @IBOutlet weak var secondLeftLabelText: UILabel!
    @IBOutlet weak var secondLeftDescLabel: UILabel!
    @IBOutlet weak var secondLeftView: UIView!
    @IBOutlet weak var secondRightBlueIcon: UIView!
    @IBOutlet weak var secondRightLabelText: UILabel!
    @IBOutlet weak var secondRightDescText: UILabel!
    @IBOutlet weak var secondRightView: UIView!
    @IBOutlet weak var fourthLeftBlueIcon: UIView!
    @IBOutlet weak var fourthLeftLabelText: UILabel!
    @IBOutlet weak var fourthLeftDescLabelText: UILabel!
    @IBOutlet weak var fourthLeftView: UIView!
    @IBOutlet weak var fourthRightView: UIView!
    @IBOutlet weak var fourthRightBlueIcon: UIView!
    @IBOutlet weak var fourthRightLabelText: UILabel!
    @IBOutlet weak var fourthRightDescLabelText: UILabel!
    @IBOutlet weak var fifthView: UIView!
    @IBOutlet weak var fifthLabelText: UILabel!
    @IBOutlet weak var fifthBlueIcon: UIView!
    @IBOutlet weak var fifthDescLabelText: UILabel!
    
    
    var popup: PopupDialog?
    
    var navigateFirstClassTapAction: ((SignUpInfo) -> ())?
    var navigateSecondClassTapAction: ((SignUpInfo) -> ())?
    var navigateFirstMentorTapAction: ((SignUpInfo) -> ())?
    var navigateSecondMentorTapAction: ((SignUpInfo) -> ())?
    var navigateClassIDTapAction: ((SignUpInfo) -> ())?
    
    
    func config() {
        mainView.cornerRadius = 10.0
        mainView.makeShadow()
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = "Lyie Bilgiler"
        
        secondLeftView.borderWidth = 1.0
        secondLeftView.borderColor = StyleManager.colors.leftTitleColor
        secondLeftBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        secondLeftBlueIcon.isHidden = true
        secondLeftLabelText.text = "1.Sınıf Kodu"
        
        secondRightView.borderWidth = 1.0
        secondRightView.borderColor = StyleManager.colors.leftTitleColor
        secondRightBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        secondRightBlueIcon.isHidden = true
        secondRightLabelText.text = "2.Sınıf Kodu"
        
        fourthLeftBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        fourthLeftBlueIcon.isHidden = true
        fourthLeftLabelText.text = "1.Mentor Kullanıcı Adı"
        fourthLeftView.borderWidth = 1.0
        fourthLeftView.borderColor = StyleManager.colors.leftTitleColor
        
        fourthRightBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        fourthRightBlueIcon.isHidden = true
        fourthRightLabelText.text = "2.Mentor Kullanıcı Adı"
        fourthRightView.borderWidth = 1.0
        fourthRightView.borderColor = StyleManager.colors.leftTitleColor
        
        fifthView.borderWidth = 1.0
        fifthView.borderColor = StyleManager.colors.leftTitleColor
        fifthLabelText.text = "Sınıf Kodu"
        fifthBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        fifthBlueIcon.isHidden = true
        
        if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey), let newUserItem = NewUserProvider.users(for: currentUserInfo) {
            if newUserItem.userType == "Mentor" {
                fourthLeftView.isHidden = true
                fourthRightView.isHidden = true
                fifthView.isHidden = true
                secondLeftView.isHidden = false
                secondRightView.isHidden = false
            }
            
            if newUserItem.userType == "Student" {
                secondLeftView.isHidden = true
                secondRightView.isHidden = true
                fourthLeftView.isHidden = false
                fourthRightView.isHidden = false
                fifthView.isHidden = false
            }
            
            if newUserItem.userType == "" {
                fourthLeftView.isHidden = false
                fourthRightView.isHidden = false
                fifthView.isHidden = false
                secondLeftView.isHidden = false
                secondRightView.isHidden = false
            }
            
            secondLeftDescLabel.text = newUserItem.FirstClass
            secondRightDescText.text = newUserItem.SecondClass
            fourthLeftDescLabelText.text = newUserItem.FirstMentor
            fourthRightDescLabelText.text = newUserItem.SecondMentor
            fifthDescLabelText.text =  newUserItem.classID
        }
    }
    
    @IBAction func secondLeftViewButtonTapped(_ sender: Any) { // Name - Surname
        LyieLog.mPrint("secondLeftViewButtonTapped")
        self.navigateFirstClassTapAction!(self)
    }
    
    @IBAction func secondRightViewButtonTapped(_ sender: Any) { // Date of Birth
        LyieLog.mPrint("secondRightViewButtonTapped")
        self.navigateSecondClassTapAction!(self)
    }
    
    @IBAction func fourthLeftViewButtonTapped(_ sender: Any) { // City
        LyieLog.mPrint("fourthLeftViewButtonTapped")
        self.navigateFirstMentorTapAction!(self)
    }
    
    @IBAction func fourthRightViewButtonTapped(_ sender: Any) { // Phone
        LyieLog.mPrint("fourthRightViewButtonTapped")
        self.navigateSecondMentorTapAction!(self)
    }
    
    @IBAction func fifthViewButtonTapped(_ sender: Any) { // Mail
        LyieLog.mPrint("fifthViewButtonTapped")
        self.navigateClassIDTapAction!(self)
    }
    
    
}


