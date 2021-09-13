//
//  SignUpUserInfo.swift
//  lyie
//
//  Created by Sevcan Eşim on 6.05.2021.
//

import UIKit
import PopupDialog
import Material
import UICheckbox_Swift

class SignUpUserInfo: UITableViewCell {
    static let reuseIdentifier = "SignUpUserInfo"
    
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet weak var leftTitleView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var secondLeftBlueIcon: UIView!
    @IBOutlet weak var secondLeftLabelText: UILabel!
    @IBOutlet weak var secondLeftDescLabel: UILabel!
    @IBOutlet weak var fourthLeftBlueIcon: UIView!
    @IBOutlet weak var fourthLeftLabelText: UILabel!
    @IBOutlet weak var fourthLeftDescLabelText: UILabel!
    @IBOutlet weak var secondLeftView: UIView!
    @IBOutlet weak var fourthLeftView: UIView!
    @IBOutlet weak var fifthView: UIView!
    @IBOutlet weak var fifthLabelText: UILabel!
    @IBOutlet weak var fifthBlueIcon: UIView!
    @IBOutlet weak var fifthDescLabelText: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var sixthLeftBlueIcon: UIView!
    @IBOutlet weak var sixthLeftLabelText: UILabel!
    @IBOutlet weak var sixthLeftDescLabel: UILabel!
    @IBOutlet weak var sixthLeftView: UIView!
    @IBOutlet weak var checkBox: UICheckbox!
    @IBOutlet weak var approvalPrivacyPolicyLabel: UILabel!
    
    var popup: PopupDialog?
    var navigateNameSurnameTapAction: ((SignUpUserInfo) -> ())?
    var navigateUserCityTapAction: ((SignUpUserInfo) -> ())?
    var navigatePhoneTapAction: ((SignUpUserInfo) -> ())?
    var navigateMailTapAction: ((SignUpUserInfo) -> ())?
    var navigateUserIDTapAction: ((SignUpUserInfo) -> ())?
    var navigatePasswordTapAction: ((SignUpUserInfo) -> ())?
    var navigateKVKKTapAction: ((SignUpUserInfo) -> ())?
    let dateFormatter = DateFormatter()
    
    func config() {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let newUserItem = NewUserProvider.users(for: user) {
            checkBox.isSelected = newUserItem.approvedKVKK
        }
        checkBoxConfig(radius: 10)
        mainView.cornerRadius = 10.0
        mainView.makeShadow()
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        horizontalView.isHidden = true
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = "Kişisel Bilgiler"
        
        secondLeftBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        secondLeftBlueIcon.isHidden = true
        secondLeftLabelText.text = "İsim Soyisim"
        
        fourthLeftBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        fourthLeftBlueIcon.isHidden = true
        fourthLeftLabelText.text = "Kullanıcı Adı"
        
        fourthLeftView.borderWidth = 1.0
        fourthLeftView.borderColor = StyleManager.colors.leftTitleColor
        
        sixthLeftBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        sixthLeftBlueIcon.isHidden = true
        sixthLeftLabelText.text = "Şifre"
        
        sixthLeftView.borderWidth = 1.0
        sixthLeftView.borderColor = StyleManager.colors.leftTitleColor
        
        secondLeftView.borderWidth = 1.0
        secondLeftView.borderColor = StyleManager.colors.leftTitleColor

        
        fifthView.borderWidth = 1.0
        fifthView.borderColor = StyleManager.colors.leftTitleColor
        fifthLabelText.text = "Mail Adresi"
        fifthBlueIcon.backgroundColor = StyleManager.colors.leftTitleColor
        fifthBlueIcon.isHidden = true
        
        if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey), let newUserItem = NewUserProvider.users(for: currentUserInfo) {
            secondLeftDescLabel.text = newUserItem.name
            fourthLeftDescLabelText.text = newUserItem.userID
            fifthDescLabelText.text = newUserItem.mail
            sixthLeftDescLabel.text = newUserItem.password
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
    
    @IBAction func secondLeftViewButtonTapped(_ sender: Any) { // Name - Surname
        LyieLog.mPrint("secondLeftViewButtonTapped")
        self.navigateNameSurnameTapAction!(self)
    }
    
    @IBAction func fourthLeftViewButtonTapped(_ sender: Any) { // City
        LyieLog.mPrint("fourthLeftViewButtonTapped")
        self.navigateUserIDTapAction!(self)
    }
    
    
    @IBAction func fifthViewButtonTapped(_ sender: Any) { // Mail
        LyieLog.mPrint("fifthViewButtonTapped")
        self.navigateMailTapAction!(self)
    }
    
    @IBAction func sixthLeftViewButtonTapped(_ sender: Any) { // Name - Surname
        LyieLog.mPrint("secondLeftViewButtonTapped")
        self.navigatePasswordTapAction!(self)
    }
    
    @IBAction func onPrivacyTap(_ sender: Any) {
        LyieLog.mPrint("KVKKButtonTapped")
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let newUserItem = NewUserProvider.users(for: user) {
            checkBox.isSelected = newUserItem.approvedKVKK
        }
        self.navigateKVKKTapAction!(self)
    }
}


