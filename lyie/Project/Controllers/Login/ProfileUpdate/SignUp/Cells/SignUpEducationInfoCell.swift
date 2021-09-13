//
//  SignUpEducationInfoCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.04.2021.
//

import UIKit
import PopupDialog

class SignUpEducationInfoCell: UITableViewCell {
    static let reuseIdentifier = "SignUpEducationInfoCell"
    
    @IBOutlet weak var leftTitleView: UIView!
    @IBOutlet weak var titleText: UILabel!
    
    @IBOutlet weak var firstLabelText: UILabel!
    @IBOutlet weak var firstBlueIcon: UIView!
    @IBOutlet weak var firstDescLabelText: UILabel!
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var secondLabelText: UILabel!
    @IBOutlet weak var secondBlueIcon: UIView!
    @IBOutlet weak var secondDescLabelText: UILabel!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var thirdLabelText: UILabel!
    @IBOutlet weak var thirdBlueIcon: UIView!
    @IBOutlet weak var thirdDescLabelText: UILabel!
    @IBOutlet weak var thirdView: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    var popup: PopupDialog?
    var navigateHSTapAction: ((SignUpEducationInfoCell) -> ())?
    var navigateUniversityTapAction: ((SignUpEducationInfoCell) -> ())?
    var navigateDepartmentTapAction: ((SignUpEducationInfoCell) -> ())?
    
    
    func config() {
        mainView.makeShadow()
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = "Eğitim Bilgileri"
        
        
        firstLabelText.text = "Lise"
        firstBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        firstBlueIcon.isHidden = true
        firstView.borderWidth = 1.0
        firstView.borderColor = StyleManager.colors.leftTitleColor
        
        secondLabelText.text = "Üniversite"
        secondBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        secondBlueIcon.isHidden = true
        secondView.borderWidth = 1.0
        secondView.borderColor = StyleManager.colors.leftTitleColor
        
        thirdLabelText.text = "Bölüm"
        thirdBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        thirdBlueIcon.isHidden = true
        thirdView.borderWidth = 1.0
        thirdView.borderColor = StyleManager.colors.leftTitleColor
        
        
        if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey), let newUserItem = NewUserProvider.users(for: currentUserInfo)  {
            if newUserItem.userType == "Mentor" {
                firstView.isHidden = true
                secondView.isHidden = false
                thirdView.isHidden = false
            }
            
            if newUserItem.userType == "Student"  {
                firstView.isHidden = false
                secondView.isHidden = true
                thirdView.isHidden = true
            }
            
            if newUserItem.userType == "" {
                firstView.isHidden = false
                secondView.isHidden = false
                thirdView.isHidden = false
            }
            
            firstDescLabelText.text = newUserItem.highSchoolName
            secondDescLabelText.text = newUserItem.University
            thirdDescLabelText.text = newUserItem.Department
        }
    }
    
    @IBAction func firstViewButtonTapped(_ sender: Any) { // High School Name
        LyieLog.mPrint("firstViewButtonTapped")
        self.navigateHSTapAction!(self)
    }
    
    @IBAction func secondViewButtonTapped(_ sender: Any) { // Class Number
        LyieLog.mPrint("secondViewButtonTapped")
        self.navigateUniversityTapAction!(self)
    }
    
    @IBAction func thirdViewButtonTapped(_ sender: Any) { // Department Name
        LyieLog.mPrint("thirdViewButtonTapped")
        self.navigateDepartmentTapAction!(self)
    }
    
}

