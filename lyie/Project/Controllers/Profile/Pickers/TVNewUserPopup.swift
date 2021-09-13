//
//  TVNewUserPopup.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.04.2021.
//

import UIKit
import PopupDialog

protocol TVNewUserDelegate {
    func onNewDismissed()
    func onChangeText(userTypeN: String)
    func onChangeText(nameN: String)
    func onChangeText(passN: String)
    func onChangeText(phoneN: String)
    func onChangeText(mailN: String)
    func onChangeText(userIDN: String)
    func onChangeText(classIDN: String)
    func onChangeText(highSchoolNameN: String)
    func onChangeText(UniversityN: String)
    func onChangeText(DepartmentN: String)
    func onChangeText(FirstMentorN: String)
    func onChangeText(SecondMentorN: String)
    func onChangeText(FirstClassN: String)
    func onChangeText(SecondClassN: String)
}

class TVNewUserPopup: UIViewController, Localizable, UITextViewDelegate {
    
    @IBOutlet weak var profileValueLabel: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tvView: UIView!
    
    var userItem: NewUserItem?
    var selectedName = ""
    var popup: PopupDialog?
    var tvDelegate: TVNewUserDelegate!
    var textViewType: Int?
    var mainEducation = ""
    var mainEducationValue = 0
    var mainEducationCellNum = 0
    
    func applyLanguage() {
        saveButton.setTitle("Kaydet", for: .normal)
        clearButton.setTitle("Sil", for: .normal)
        
        saveButton.backgroundColor = StyleManager.colors.leftTitleColor
        clearButton.backgroundColor = StyleManager.colors.leftTitleColor
        
        profileValueLabel.borderWidth = 1.0
        profileValueLabel.borderColor = .lightGray
        
        tvView.borderColor = StyleManager.colors.borderColorBlue
        profileValueLabel.borderWidth = 0
        
        
        switch textViewType {
        case 0:
            titleLabel.text = "Kullanıcı Tipi"
            profileValueLabel.keyboardType = .alphabet
        case 1:
            titleLabel.text = "İsim / Soyisim"
            profileValueLabel.keyboardType = .alphabet
        case 2:
            titleLabel.text = "Şifre"
            profileValueLabel.keyboardType = .alphabet
        case 3:
            titleLabel.text = "Telefon Numarası"
            profileValueLabel.keyboardType = .phonePad
        case 4:
            titleLabel.text = "Mail"
            profileValueLabel.keyboardType = .emailAddress
        case 5:
            titleLabel.text = "Kullanıcı Adı"
            profileValueLabel.keyboardType = .alphabet
        case 6:
            titleLabel.text = "Sınıf Kodu"
            profileValueLabel.keyboardType = .alphabet
        case 7:
            titleLabel.text = "Lise"
            profileValueLabel.keyboardType = .alphabet
        case 8:
            titleLabel.text = "Üniversite"
            profileValueLabel.keyboardType = .alphabet
        case 9:
            titleLabel.text = "Bölüm"
            profileValueLabel.keyboardType = .alphabet
        case 10:
            titleLabel.text = "1. Mentor Kullanıcı Adı"
            profileValueLabel.keyboardType = .alphabet
        case 11:
            titleLabel.text = "2. Mentor Kullanıcı Adı"
            profileValueLabel.keyboardType = .alphabet
        case 12:
            titleLabel.text = "1. Sınıf Kodu"
            profileValueLabel.keyboardType = .alphabet
        case 13:
            titleLabel.text = "2.Sınıf Kodu"
            profileValueLabel.keyboardType = .alphabet
        default:
            titleLabel.text = ""
        }
    }
    
    @IBAction func saveTF(_ sender: Any) {
        if profileValueLabel.text != "" {
            switch textViewType {
            case 0:
                tvDelegate.onChangeText(userTypeN: profileValueLabel.text!.removingLeadingSpaces())
            case 1:
                tvDelegate.onChangeText(nameN: profileValueLabel.text!.removingLeadingSpaces())
            case 2:
                tvDelegate.onChangeText(passN: profileValueLabel.text!.removingLeadingSpaces())
            case 3:
                tvDelegate.onChangeText(phoneN: profileValueLabel.text!.removingLeadingSpaces())
            case 4:
                tvDelegate.onChangeText(mailN: profileValueLabel.text!.removingLeadingSpaces())
            case 5:
                tvDelegate.onChangeText(userIDN: profileValueLabel.text!.removingLeadingSpaces())
            case 6:
                tvDelegate.onChangeText(classIDN: profileValueLabel.text!.removingLeadingSpaces())
            case 7:
                tvDelegate.onChangeText(highSchoolNameN: profileValueLabel.text!.removingLeadingSpaces())
            case 8:
                tvDelegate.onChangeText(UniversityN: profileValueLabel.text!.removingLeadingSpaces())
            case 9:
                tvDelegate.onChangeText(DepartmentN: profileValueLabel.text!.removingLeadingSpaces())
            case 10:
                tvDelegate.onChangeText(FirstMentorN: profileValueLabel.text!.removingLeadingSpaces())
            case 11:
                tvDelegate.onChangeText(SecondMentorN: profileValueLabel.text!.removingLeadingSpaces())
            case 12:
                tvDelegate.onChangeText(FirstClassN: profileValueLabel.text!.removingLeadingSpaces())
            case 13:
                tvDelegate.onChangeText(SecondClassN: profileValueLabel.text!.removingLeadingSpaces())
            default:
                tvDelegate.onChangeText(SecondClassN: profileValueLabel.text!.removingLeadingSpaces())
            }
        }
        tvDelegate.onNewDismissed()
    }
    
    @IBAction func clearTF(_ sender: Any) {
        if profileValueLabel.text != "" {
            switch textViewType {
            case 0:
                tvDelegate.onChangeText(userTypeN: "")
            case 1:
                tvDelegate.onChangeText(nameN: "")
            case 2:
                tvDelegate.onChangeText(passN: "")
            case 3:
                tvDelegate.onChangeText(phoneN: "")
            case 4:
                tvDelegate.onChangeText(mailN: "")
            case 5:
                tvDelegate.onChangeText(userIDN: "")
            case 6:
                tvDelegate.onChangeText(classIDN: "")
            case 7:
                tvDelegate.onChangeText(highSchoolNameN: "")
            case 8:
                tvDelegate.onChangeText(UniversityN: "")
            case 9:
                tvDelegate.onChangeText(DepartmentN: "")
            case 10:
                tvDelegate.onChangeText(FirstMentorN: "")
            case 11:
                tvDelegate.onChangeText(SecondMentorN: "")
            case 12:
                tvDelegate.onChangeText(FirstClassN: "")
            case 13:
                tvDelegate.onChangeText(SecondClassN: "")
            default:
                tvDelegate.onChangeText(SecondClassN: "")
            }
        }
        tvDelegate.onNewDismissed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingLanguage()
        profileValueLabel.backgroundColor = .white
        fillData()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc func endEditing() {
        view.endEditing(true)
    }

    
    @IBAction func cancel(_ sender: Any) {
        tvDelegate.onNewDismissed()
    }
}

extension TVNewUserPopup {
    fileprivate func fillData() {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), let newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        
        switch textViewType {
        case 0:
            profileValueLabel.text = newUserItem.userType
        case 1:
            profileValueLabel.text = newUserItem.name
        case 2:
            profileValueLabel.text = newUserItem.password
        case 3:
            profileValueLabel.text = newUserItem.phone
        case 4:
            profileValueLabel.text = newUserItem.mail
        case 5:
            profileValueLabel.text = newUserItem.userID
        case 6:
            profileValueLabel.text = newUserItem.classID
        case 7:
            profileValueLabel.text = newUserItem.highSchoolName
        case 8:
            profileValueLabel.text = newUserItem.University
        case 9:
            profileValueLabel.text = newUserItem.Department
        case 10:
            profileValueLabel.text = newUserItem.FirstMentor
        case 11:
            profileValueLabel.text = newUserItem.SecondMentor
        case 12:
            profileValueLabel.text = newUserItem.FirstClass
        case 13:
            profileValueLabel.text = newUserItem.SecondClass
        default:
            profileValueLabel.text = newUserItem.SecondClass
        }
    }
}

extension TVNewUserPopup: ForceTextChangeDelegate {
    func onTextShouldRevert(text: String) {
         profileValueLabel.text = text
    }
}

extension TVNewUserPopup: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            switch textViewType {
            case 0:
                tvDelegate.onChangeText(userTypeN: profileValueLabel.text!.removingLeadingSpaces())
            case 1:
                tvDelegate.onChangeText(nameN: profileValueLabel.text!.removingLeadingSpaces())
            case 2:
                tvDelegate.onChangeText(passN: profileValueLabel.text!.removingLeadingSpaces())
            case 3:
                tvDelegate.onChangeText(phoneN: profileValueLabel.text!.removingLeadingSpaces())
            case 4:
                tvDelegate.onChangeText(mailN: profileValueLabel.text!.removingLeadingSpaces())
            case 5:
                tvDelegate.onChangeText(userIDN: profileValueLabel.text!.removingLeadingSpaces())
            case 6:
                tvDelegate.onChangeText(classIDN: profileValueLabel.text!.removingLeadingSpaces())
            case 7:
                tvDelegate.onChangeText(highSchoolNameN: profileValueLabel.text!.removingLeadingSpaces())
            case 8:
                tvDelegate.onChangeText(UniversityN: profileValueLabel.text!.removingLeadingSpaces())
            case 9:
                tvDelegate.onChangeText(DepartmentN: profileValueLabel.text!.removingLeadingSpaces())
            case 10:
                tvDelegate.onChangeText(FirstMentorN: profileValueLabel.text!.removingLeadingSpaces())
            case 11:
                tvDelegate.onChangeText(SecondMentorN: profileValueLabel.text!.removingLeadingSpaces())
            case 12:
                tvDelegate.onChangeText(FirstClassN: profileValueLabel.text!.removingLeadingSpaces())
            case 13:
                tvDelegate.onChangeText(SecondClassN: profileValueLabel.text!.removingLeadingSpaces())
            default:
                tvDelegate.onChangeText(SecondClassN: profileValueLabel.text!.removingLeadingSpaces())
            }
        }
    }
}

