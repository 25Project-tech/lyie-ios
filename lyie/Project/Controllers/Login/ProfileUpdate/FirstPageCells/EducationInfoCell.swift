//
//  EducationInfoCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.11.2020.
//

import UIKit
import PopupDialog
import UICheckbox_Swift

class EducationInfoCell: UITableViewCell {
    static let reuseIdentifier = "EducationInfoCell"
    
    @IBOutlet weak var leftTitleView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var firstLabelText: UILabel!
    @IBOutlet weak var firstBlueIcon: UIView!
    @IBOutlet weak var firstDescLabelText: UILabel!
    @IBOutlet weak var secondLeftBlueIcon: UIView!
    @IBOutlet weak var secondLeftLabelText: UILabel!
    @IBOutlet weak var secondLeftDescLabel: UILabel!
    @IBOutlet weak var secondRightBlueIcon: UIView!
    @IBOutlet weak var secondRightLabelText: UILabel!
    @IBOutlet weak var secondRightDescLabel: UILabel!
    @IBOutlet weak var thirdBlueIcon: UIView!
    @IBOutlet weak var thirdLabelText: UILabel!
    @IBOutlet weak var thirdDescLabel: UILabel!
    @IBOutlet weak var fourthBlueIcon: UIView!
    @IBOutlet weak var fourthLabelText: UILabel!
    @IBOutlet weak var fourthDescLabel: UILabel!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondLeftView: UIView!
    @IBOutlet weak var secondRightView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var checkBox: UICheckbox!
    @IBOutlet weak var approvalPrivacyPolicyLabel: UILabel!
    
    var popup: PopupDialog?
    var navigateHSTapAction: ((EducationInfoCell) -> ())?
    var navigateClassTapAction: ((EducationInfoCell) -> ())?
    var navigateDepartmentTapAction: ((EducationInfoCell) -> ())?
    var navigateTargetUniversityTapAction: ((EducationInfoCell) -> ())?
    var navigateTargetDepartmentTapAction: ((EducationInfoCell) -> ())?
    var navigateKVKKTapAction: ((EducationInfoCell) -> ())?
    
    func config() {
        checkBoxConfig(radius: 10)
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let newUserItem = NewUserProvider.users(for: user) {
            checkBox.isSelected = newUserItem.approvedKVKK
        }
        mainView.makeShadow()
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = "Eğitim Bilgileri"
        firstLabelText.text = "Lise"
        firstBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        firstBlueIcon.isHidden = true
        secondLeftBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        secondLeftBlueIcon.isHidden = true
        secondLeftLabelText.text = "Sınıf"
        secondRightBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        secondRightBlueIcon.isHidden = true
        secondRightLabelText.text = "Bölüm"
        thirdBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        thirdBlueIcon.isHidden = true
        thirdLabelText.text = "Hedeflenen Üniversite"
        fourthBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        fourthBlueIcon.isHidden = true
        fourthLabelText.text = "Hedeflenen Bölüm"
        firstView.borderWidth = 1.0
        firstView.borderColor = StyleManager.colors.leftTitleColor
        secondLeftView.borderWidth = 1.0
        secondLeftView.borderColor = StyleManager.colors.leftTitleColor
        secondRightView.borderWidth = 1.0
        secondRightView.borderColor = StyleManager.colors.leftTitleColor
        thirdView.borderWidth = 1.0
        thirdView.borderColor = StyleManager.colors.leftTitleColor
        fourthView.borderWidth = 1.0
        fourthView.borderColor = StyleManager.colors.leftTitleColor
        
        if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey) {
            if let studentInfoItem = StudentInfoProvider.studentInfos(for: currentUserInfo) {
                firstDescLabelText.text = studentInfoItem.highSchoolName
                secondLeftDescLabel.text = studentInfoItem.classNumber
                secondRightDescLabel.text = studentInfoItem.departmentName
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
    
    @IBAction func firstViewButtonTapped(_ sender: Any) { // High School Name
        LyieLog.mPrint("firstViewButtonTapped")
        self.navigateHSTapAction!(self)
    }
    
    @IBAction func secondLeftViewButtonTapped(_ sender: Any) { // Class Number
        LyieLog.mPrint("secondLeftViewButtonTapped")
        self.navigateClassTapAction!(self)
    }
    
    @IBAction func secondRightViewButtonTapped(_ sender: Any) { // Department Name
        LyieLog.mPrint("secondRightViewButtonTapped")
        self.navigateDepartmentTapAction!(self)
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
