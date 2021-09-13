//
//  PersonalInfoCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.11.2020.
//

import UIKit
import PopupDialog

class PersonalInfoCell: UITableViewCell {
    static let reuseIdentifier = "PersonalInfoCell"
    
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet weak var leftTitleView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var firstLabelText: UILabel!
    @IBOutlet weak var firstBlueIcon: UIView!
    @IBOutlet weak var firstDescLabelText: UILabel!
    @IBOutlet weak var secondLeftBlueIcon: UIView!
    @IBOutlet weak var secondLeftLabelText: UILabel!
    @IBOutlet weak var secondLeftDescLabel: UILabel!
    @IBOutlet weak var secondRightBlueIcon: UIView!
    @IBOutlet weak var secondRightLabelText: UILabel!
    @IBOutlet weak var secondRightDescText: UILabel!
    @IBOutlet weak var thirdLeftBlueIcon: UIView!
    @IBOutlet weak var thirdLeftLabelText: UILabel!
    @IBOutlet weak var thirdLeftDescLabel: UILabel!
    @IBOutlet weak var thirdRightBlueIcon: UIView!
    @IBOutlet weak var thirdRightLabelText: UILabel!
    @IBOutlet weak var thirdRightDescText: UILabel!
    @IBOutlet weak var fourthLeftBlueIcon: UIView!
    @IBOutlet weak var fourthLeftLabelText: UILabel!
    @IBOutlet weak var fourthLeftDescLabelText: UILabel!
    @IBOutlet weak var fourthRightBlueIcon: UIView!
    @IBOutlet weak var fourthRightLabelText: UILabel!
    @IBOutlet weak var fourthRightDescLabelText: UILabel!
    @IBOutlet weak var secondLeftView: UIView!
    @IBOutlet weak var secondRightView: UIView!
    @IBOutlet weak var thirdLeftView: UIView!
    @IBOutlet weak var thirdRightView: UIView!
    @IBOutlet weak var fourthLeftView: UIView!
    @IBOutlet weak var fourthRightView: UIView!
    @IBOutlet weak var fifthView: UIView!
    @IBOutlet weak var fifthLabelText: UILabel!
    @IBOutlet weak var fifthBlueIcon: UIView!
    @IBOutlet weak var fifthDescLabelText: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    var popup: PopupDialog?
    var navigateTargetTapAction: ((PersonalInfoCell) -> ())?
    var navigateNameSurnameTapAction: ((PersonalInfoCell) -> ())?
    var navigateDateOfBirthTapAction: ((PersonalInfoCell) -> ())?
    var navigatePlaceOfBirthTapAction: ((PersonalInfoCell) -> ())?
    var navigateGenderTapAction: ((PersonalInfoCell) -> ())?
    var navigateCityTapAction: ((PersonalInfoCell) -> ())?
    var navigatePhoneTapAction: ((PersonalInfoCell) -> ())?
    var navigateMailTapAction: ((PersonalInfoCell) -> ())?
    let dateFormatter = DateFormatter()
    
    func config() {
        dateFormatter.dateFormat = "dd-MM-yyyy"
        mainView.cornerRadius = 10.0
        mainView.makeShadow()
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = "Kişisel Bilgiler"
        firstView.borderWidth = 1.0
        firstView.borderColor = StyleManager.colors.leftTitleColor
        firstLabelText.text = "Amaç"
        firstBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        firstBlueIcon.isHidden = true
        secondLeftBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        secondLeftBlueIcon.isHidden = true
        secondLeftLabelText.text = "İsim Soyisim"
        secondRightBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        secondRightBlueIcon.isHidden = true
        secondRightLabelText.text = "Doğum Tarihi"
        thirdLeftBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        thirdLeftBlueIcon.isHidden = true
        thirdLeftLabelText.text = "Doğum Yeri"
        thirdRightBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        thirdRightBlueIcon.isHidden = true
        thirdRightLabelText.text = "Cinsiyet"
        fourthLeftBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        fourthLeftBlueIcon.isHidden = true
        fourthLeftLabelText.text = "İkamet Yeri"
        fourthRightBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        fourthRightBlueIcon.isHidden = true
        fourthRightLabelText.text = "Cep Telefonu"
        secondLeftView.borderWidth = 1.0
        secondLeftView.borderColor = StyleManager.colors.leftTitleColor
        secondRightView.borderWidth = 1.0
        secondRightView.borderColor = StyleManager.colors.leftTitleColor
        thirdLeftView.borderWidth = 1.0
        thirdLeftView.borderColor = StyleManager.colors.leftTitleColor
        thirdRightView.borderWidth = 1.0
        thirdRightView.borderColor = StyleManager.colors.leftTitleColor
        fourthLeftView.borderWidth = 1.0
        fourthLeftView.borderColor = StyleManager.colors.leftTitleColor
        fourthRightView.borderWidth = 1.0
        fourthRightView.borderColor = StyleManager.colors.leftTitleColor
        fifthView.borderWidth = 1.0
        fifthView.borderColor = StyleManager.colors.leftTitleColor
        fifthLabelText.text = "Mail Adresi"
        fifthBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        fifthBlueIcon.isHidden = true
        
        if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey) {
            if let userItem = UserProvider.users(for: currentUserInfo) {
                firstDescLabelText.text = userItem.targetString
                secondLeftDescLabel.text = userItem.name
                if userItem.dateofBirth != nil {
                    if userItem.dateofBirth?.timeIntervalSince1970 != 0 {
                        secondRightDescText.text = self.dateFormatter.string(from: userItem.dateofBirth!)
                    }
                } else {
                    secondRightDescText.text = ""
                }
                
                if userItem.placeofBirth != 0  {
                    thirdLeftDescLabel.text = CityServices.getNameWithLicensePlateId(by: userItem.placeofBirth)
                } else {
                    thirdLeftDescLabel.text = CityServices.getNameWithLicensePlateId(by: 1)
                }
                
                if userItem.city != 0  {
                    fourthLeftDescLabelText.text = CityServices.getNameWithLicensePlateId(by: userItem.city)
                } else {
                    fourthLeftDescLabelText.text = CityServices.getNameWithLicensePlateId(by: 1)
                }
                
                thirdRightDescText.text = userItem.gender
                fourthRightDescLabelText.text = userItem.phone
                fifthDescLabelText.text = userItem.mail
            }
        }
    }
    
    @IBAction func firstViewButton(_ sender: Any) {
        LyieLog.mPrint("firstViewButtonTapped") // Target String
        self.navigateTargetTapAction!(self)
    }
    
    @IBAction func secondLeftViewButtonTapped(_ sender: Any) { // Name - Surname
        LyieLog.mPrint("secondLeftViewButtonTapped")
        self.navigateNameSurnameTapAction!(self)
    }
    
    @IBAction func secondRightViewButtonTapped(_ sender: Any) { // Date of Birth
        LyieLog.mPrint("secondRightViewButtonTapped")
        self.navigateDateOfBirthTapAction!(self)
    }
    
    @IBAction func thirdLeftViewButtonTapped(_ sender: Any) { // Place of Birth
        LyieLog.mPrint("thirdLeftViewButtonTapped")
        self.navigatePlaceOfBirthTapAction!(self)
    }
    
    @IBAction func thirdRightViewButtonTapped(_ sender: Any) { // Gender
        LyieLog.mPrint("thirdRightViewButtonTapped")
        self.navigateGenderTapAction!(self)
    }
    
    @IBAction func fourthLeftViewButtonTapped(_ sender: Any) { // City
        LyieLog.mPrint("fourthLeftViewButtonTapped")
        self.navigateCityTapAction!(self)
    }
    
    @IBAction func fourthRightViewButtonTapped(_ sender: Any) { // Phone
        LyieLog.mPrint("fourthRightViewButtonTapped")
        self.navigatePhoneTapAction!(self)
    }
    
    @IBAction func fifthViewButtonTapped(_ sender: Any) { // Mail
        LyieLog.mPrint("fifthViewButtonTapped")
        self.navigateMailTapAction!(self)
    }
    
    
}
