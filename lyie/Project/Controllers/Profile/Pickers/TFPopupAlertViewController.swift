//
//  TFPopupAlertViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 13.12.2020.
//

import UIKit
import PopupDialog

protocol TFDelegate {
    func onTFDismissed()
    func onChangeText(nameSurname: String)
//    func onChangeText(target: String)
    func onChangeText(mail: String)
    func onChangeText(phone: String)
    func onChangeText(highSchollName: String)
    func onChangeText(targetUni: String)
    func onChangeText(targetDept: String)
}

protocol ForceTextChangeDelegate {
    func onTextShouldRevert(text: String)
}

class TFPopupAlertViewController: UIViewController, Localizable {
    
    @IBOutlet weak var profileValueLabel: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tfView: UIView!
    
    var userItem: UserItem?
    var selectedName = ""
    var popup: PopupDialog?
    var tfDelegate: TFDelegate!
    var textFieldType: Int? //0 -> name // 1 -> target // 2-> mail // 3 -> phone // 4 -> hs name
    
    func applyLanguage() {
        saveButton.setTitle("Kaydet", for: .normal)
        clearButton.setTitle("Sil", for: .normal)
        
        saveButton.backgroundColor = StyleManager.colors.leftTitleColor
        clearButton.backgroundColor = StyleManager.colors.leftTitleColor
        
        profileValueLabel.borderWidth = 1.0
        profileValueLabel.borderColor = .lightGray
        
        tfView.borderColor = StyleManager.colors.borderColorBlue
        profileValueLabel.borderStyle = .none
        profileValueLabel.borderWidth = 0
        
        
        switch textFieldType {
        case 0:
            titleLabel.text = "İsim Soyisim"
            profileValueLabel.keyboardType = .alphabet
//        case 1:
//            titleLabel.text = "Amaç"
//            profileValueLabel.keyboardType = .alphabet
        case 2:
            titleLabel.text = "Mail Adresi"
            profileValueLabel.keyboardType = .emailAddress
        case 3:
            titleLabel.text = "Cep Telefonu"
            profileValueLabel.keyboardType = .phonePad
        case 4:
            titleLabel.text = "Lise"
            profileValueLabel.keyboardType = .alphabet
        case 5:
            titleLabel.text = "Üniversite"
            profileValueLabel.keyboardType = .alphabet
        case 6:
            titleLabel.text = "Bölüm"
            profileValueLabel.keyboardType = .alphabet
        default:
            titleLabel.text = ""
        }
        profileValueLabel.placeholder = titleLabel.text
    }
    
    @IBAction func saveTF(_ sender: Any) {
        if profileValueLabel.text != "" {
            if textFieldType == 0 {
                tfDelegate.onChangeText(nameSurname: profileValueLabel.text!.removingLeadingSpaces())
            } else if textFieldType == 1 {
//                tfDelegate.onChangeText(target: profileValueLabel.text!.removingLeadingSpaces())
            } else if textFieldType == 2 {
                tfDelegate.onChangeText(mail: profileValueLabel.text!.removingLeadingSpaces())
            } else if textFieldType == 3 {
                tfDelegate.onChangeText(phone: profileValueLabel.text!.removingLeadingSpaces())
            } else if textFieldType == 4 {
                tfDelegate.onChangeText(highSchollName: profileValueLabel.text!.removingLeadingSpaces())
            } else if textFieldType == 5 {
                tfDelegate.onChangeText(targetUni: profileValueLabel.text!.removingLeadingSpaces())
            } else {
                tfDelegate.onChangeText(targetDept: profileValueLabel.text!.removingLeadingSpaces())
            }
        }
        tfDelegate.onTFDismissed()
    }
    
    @IBAction func clearTF(_ sender: Any) {
        if profileValueLabel.text != "" {
            if textFieldType! == 0 {
                tfDelegate.onChangeText(nameSurname: "")
            } else if textFieldType! == 1 {
//                tfDelegate.onChangeText(target: "")
            } else if textFieldType! == 2 {
                tfDelegate.onChangeText(mail: "")
            } else if textFieldType! == 3 {
                tfDelegate.onChangeText(phone: "")
            } else if textFieldType! == 4 {
                tfDelegate.onChangeText(highSchollName: "")
            } else if textFieldType! == 5 {
                tfDelegate.onChangeText(targetUni: "")
            } else {
                tfDelegate.onChangeText(targetDept: "")
            }
        }
        tfDelegate.onTFDismissed()
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
        tfDelegate.onTFDismissed()
    }
}

extension TFPopupAlertViewController {
    fileprivate func fillData() {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), let userItem = UserProvider.users(for: user), let studentInfoItem = StudentInfoProvider.studentInfos(for: user) else {
            return
        }
        
        if textFieldType == 0 {
            profileValueLabel.text = userItem.name
        } else if textFieldType == 1 {
//            profileValueLabel.text = userItem.targetString
        } else if textFieldType == 2 {
            profileValueLabel.text = userItem.mail
        } else if textFieldType == 3 {
            profileValueLabel.text = userItem.phone
        } else if textFieldType == 4 {
            profileValueLabel.text = studentInfoItem.highSchoolName
        } else if textFieldType == 5 {
            profileValueLabel.text = studentInfoItem.targetUniversity
        } else {
            profileValueLabel.text = studentInfoItem.targetDepartment
        }
    }
}

extension TFPopupAlertViewController: ForceTextChangeDelegate {
    func onTextShouldRevert(text: String) {
         profileValueLabel.text = text
    }
}

extension TFPopupAlertViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            if textFieldType! == 0 {
                tfDelegate.onChangeText(nameSurname: profileValueLabel.text!.removingLeadingSpaces())
            } else if textFieldType! == 1 {
//                tfDelegate.onChangeText(target: profileValueLabel.text!.removingLeadingSpaces())
            } else if textFieldType! == 2 {
                tfDelegate.onChangeText(mail: profileValueLabel.text!.removingLeadingSpaces())
            } else if textFieldType! == 3 {
                tfDelegate.onChangeText(phone: profileValueLabel.text!.removingLeadingSpaces())
            } else if textFieldType! == 4 {
                tfDelegate.onChangeText(highSchollName: profileValueLabel.text!.removingLeadingSpaces())
            } else if textFieldType! == 5 {
                tfDelegate.onChangeText(targetUni: profileValueLabel.text!.removingLeadingSpaces())
            } else {
                tfDelegate.onChangeText(targetDept: profileValueLabel.text!.removingLeadingSpaces())
            }
        }
    }
}
