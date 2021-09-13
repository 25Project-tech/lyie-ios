//
//  EducationInfoMentorCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 17.04.2021.
//

import UIKit
import PopupDialog
import UICheckbox_Swift

class EducationInfoMentorCell: UITableViewCell {
    static let reuseIdentifier = "EducationInfoMentorCell"
    
    @IBOutlet weak var leftTitleView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var thirdBlueIcon: UIView!
    @IBOutlet weak var thirdLabelText: UILabel!
    @IBOutlet weak var thirdDescLabel: UILabel!
    @IBOutlet weak var fourthBlueIcon: UIView!
    @IBOutlet weak var fourthLabelText: UILabel!
    @IBOutlet weak var fourthDescLabel: UILabel!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var checkBox: UICheckbox!
    @IBOutlet weak var approvalPrivacyPolicyLabel: UILabel!
    
    var popup: PopupDialog?
    var navigateTargetUniversityTapAction: ((EducationInfoMentorCell) -> ())?
    var navigateTargetDepartmentTapAction: ((EducationInfoMentorCell) -> ())?
    var navigateKVKKTapAction: ((EducationInfoMentorCell) -> ())?
    
    func config() {
        checkBoxConfig(radius: 10)
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let newUserItem = NewUserProvider.users(for: user) {
            checkBox.isSelected = newUserItem.approvedKVKK
        }
        mainView.makeShadow()
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = "Eğitim Bilgileri"
        thirdBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        thirdBlueIcon.isHidden = true
        thirdLabelText.text = "Üniversite"
        fourthBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        fourthBlueIcon.isHidden = true
        fourthLabelText.text = "Bölüm"
        thirdView.borderWidth = 1.0
        thirdView.borderColor = StyleManager.colors.leftTitleColor
        fourthView.borderWidth = 1.0
        fourthView.borderColor = StyleManager.colors.leftTitleColor
        
        if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey) {
            if let studentInfoItem = StudentInfoProvider.studentInfos(for: currentUserInfo) {
                thirdDescLabel.text = studentInfoItem.targetUniversity
                fourthDescLabel.text = studentInfoItem.targetDepartment
            }
        }
    }
    
    func checkBoxConfig(radius: Int) {
        checkBox.cornerRadius = CGFloat(radius)
        checkBox.isDividerHidden = true
        checkBox.borderWidth = 1.5
        checkBox.borderColor = StyleManager.colors.leftTitleColor
        checkBox.dividerColor = StyleManager.colors.leftTitleColor
        checkBox.tintColor = StyleManager.colors.leftTitleColor
    }
    
    @IBAction func thirdViewButtonTapped(_ sender: Any) { // Target University
        LyieLog.mPrint("thirdLeftViewButtonTapped")
        self.navigateTargetUniversityTapAction!(self)
    }
    
    @IBAction func fourthViewButtonTapped(_ sender: Any) { // Target Department
        LyieLog.mPrint("thirdRightViewButtonTapped")
        self.navigateTargetDepartmentTapAction!(self)
    }
    
    @IBAction func onPrivacyTap(_ sender: Any) {
        LyieLog.mPrint("KVKKButtonTapped")
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let newUserItem = NewUserProvider.users(for: user) {
            checkBox.isSelected = newUserItem.approvedKVKK
        }
        self.navigateKVKKTapAction!(self)
    }
}

