//
//  SignUpPersonalInfoCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.04.2021.
//

import UIKit
import PopupDialog

class SignUpPersonalInfoCell: UITableViewCell {
    static let reuseIdentifier = "SignUpPersonalInfoCell"
    
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet weak var leftTitleView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var secondLeftBlueIcon: UIView!
    @IBOutlet weak var secondLeftLabelText: UILabel!
    @IBOutlet weak var secondLeftDescLabel: UILabel!
    @IBOutlet weak var secondRightBlueIcon: UIView!
    @IBOutlet weak var secondRightLabelText: UILabel!
    @IBOutlet weak var secondRightDescText: UILabel!
    @IBOutlet weak var fourthLeftBlueIcon: UIView!
    @IBOutlet weak var fourthLeftLabelText: UILabel!
    @IBOutlet weak var fourthLeftDescLabelText: UILabel!
    @IBOutlet weak var fourthRightBlueIcon: UIView!
    @IBOutlet weak var fourthRightLabelText: UILabel!
    @IBOutlet weak var fourthRightDescLabelText: UILabel!
    @IBOutlet weak var secondLeftView: UIView!
    @IBOutlet weak var secondRightView: UIView!
    @IBOutlet weak var fourthLeftView: UIView!
    @IBOutlet weak var fourthRightView: UIView!
    @IBOutlet weak var fifthView: UIView!
    @IBOutlet weak var fifthLabelText: UILabel!
    @IBOutlet weak var fifthBlueIcon: UIView!
    @IBOutlet weak var fifthDescLabelText: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var sixthLeftBlueIcon: UIView!
    @IBOutlet weak var sixthLeftLabelText: UILabel!
    @IBOutlet weak var sixthLeftDescLabel: UILabel!
    @IBOutlet weak var sixthRightBlueIcon: UIView!
    @IBOutlet weak var sixthRightLabelText: UILabel!
    @IBOutlet weak var sixthRightDescText: UILabel!
    @IBOutlet weak var sixthLeftView: UIView!
    @IBOutlet weak var sixthRightView: UIView!
    
    var popup: PopupDialog?
    
    var navigateNameSurnameTapAction: ((SignUpPersonalInfoCell) -> ())?
    var navigateUserTypeTapAction: ((SignUpPersonalInfoCell) -> ())?
    var navigatePhoneTapAction: ((SignUpPersonalInfoCell) -> ())?
    var navigateMailTapAction: ((SignUpPersonalInfoCell) -> ())?
    var navigateUserIDTapAction: ((SignUpPersonalInfoCell) -> ())?
    var navigatePasswordTapAction: ((SignUpPersonalInfoCell) -> ())?
    
    let dateFormatter = DateFormatter()
    
    func config() {
        
        mainView.cornerRadius = 10.0
        mainView.makeShadow()
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = "Kişisel Bilgiler"
        
        secondLeftBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        secondLeftBlueIcon.isHidden = true
        secondLeftLabelText.text = "İsim Soyisim"
        secondRightBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        secondRightBlueIcon.isHidden = true
        secondRightLabelText.text = "Kullanıcı Türü"
        
        fourthLeftBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        fourthLeftBlueIcon.isHidden = true
        fourthLeftLabelText.text = "Kullanıcı Adı"
        fourthRightBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        fourthRightBlueIcon.isHidden = true
        fourthRightLabelText.text = "Cep Telefonu"
        fourthLeftView.borderWidth = 1.0
        fourthLeftView.borderColor = StyleManager.colors.leftTitleColor
        fourthRightView.borderWidth = 1.0
        fourthRightView.borderColor = StyleManager.colors.leftTitleColor
        
        
        sixthLeftBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        sixthLeftBlueIcon.isHidden = true
        sixthLeftLabelText.text = "Şifre"
        sixthRightBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        sixthRightView.isHidden = true
        sixthRightBlueIcon.isHidden = true
        sixthRightLabelText.text = "Şifre"
        sixthLeftView.borderWidth = 1.0
        sixthLeftView.borderColor = StyleManager.colors.leftTitleColor
        sixthRightView.borderWidth = 1.0
        sixthRightView.borderColor = StyleManager.colors.leftTitleColor

        secondLeftView.borderWidth = 1.0
        secondLeftView.borderColor = StyleManager.colors.leftTitleColor
        secondRightView.borderWidth = 1.0
        secondRightView.borderColor = StyleManager.colors.leftTitleColor
        
        
        fifthView.borderWidth = 1.0
        fifthView.borderColor = StyleManager.colors.leftTitleColor
        fifthLabelText.text = "Mail Adresi"
        fifthBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        fifthBlueIcon.isHidden = true
        
        if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey), let newUserItem = NewUserProvider.users(for: currentUserInfo) {
            secondLeftDescLabel.text = newUserItem.name
            secondRightDescText.text = newUserItem.userType
            fourthLeftDescLabelText.text = newUserItem.userID
            fourthRightDescLabelText.text = newUserItem.phone
            fifthDescLabelText.text = newUserItem.mail
            sixthLeftDescLabel.text = newUserItem.password
        }
    }
    
    @IBAction func secondLeftViewButtonTapped(_ sender: Any) { // Name - Surname
        LyieLog.mPrint("secondLeftViewButtonTapped")
        self.navigateNameSurnameTapAction!(self)
    }
    
    @IBAction func secondRightViewButtonTapped(_ sender: Any) { // Date of Birth
        LyieLog.mPrint("secondRightViewButtonTapped")
        self.navigateUserTypeTapAction!(self)
    }
    
    @IBAction func fourthLeftViewButtonTapped(_ sender: Any) { // City
        LyieLog.mPrint("fourthLeftViewButtonTapped")
        self.navigateUserIDTapAction!(self)
    }
    
    @IBAction func fourthRightViewButtonTapped(_ sender: Any) { // Phone
        LyieLog.mPrint("fourthRightViewButtonTapped")
        self.navigatePhoneTapAction!(self)
    }
    
    @IBAction func fifthViewButtonTapped(_ sender: Any) { // Mail
        LyieLog.mPrint("fifthViewButtonTapped")
        self.navigateMailTapAction!(self)
    }
    
    @IBAction func sixthLeftViewButtonTapped(_ sender: Any) { // Name - Surname
        LyieLog.mPrint("secondLeftViewButtonTapped")
        self.navigatePasswordTapAction!(self)
    }
    
}

