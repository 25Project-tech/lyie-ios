//
//  StringPickerViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 20.12.2020.
//

import UIKit

class StringPickerViewController: UIViewController, Localizable {
    var userItem: UserItem?
    var userInfoPickerDelegate: UserInfoPickerDelegate?
    
    var selectedGender = ""
    var selectedClassNumber = ""
    var selectedDepartmentName = ""
    var selecteedType = ""
    
    var gender: [String] = [.localized(.male), .localized(.female)]
    var classNumber: [String] = ["1", "2", "3", "4"]
    var departmentName: [String] = ["Sayısal", "Eşit Ağırlık", "Sözel", "Yabancı Dil"]
    var userType: [String] = ["Student", "Mentor"]
    
    var pickerType: Int? //0 -> gender // 1 -> classNum // 2-> departmentName  //3->  userType
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var picker: UIPickerView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var pickerView: UIView!
    
    
    func applyLanguage() {
        saveButton.setTitle("Kaydet", for: .normal)
        clearButton.setTitle("Sil", for: .normal)
        
        switch pickerType {
        case 0:
            titleLabel.text = "Cinsiyet"
        case 1:
            titleLabel.text = "Sınıf"
        case 2:
            titleLabel.text = "Bölüm"
        case 3:
            titleLabel.text = "Kullanıcı Tipi"
        default:
            LyieLog.mPrint("Default")
        }
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        switch pickerType {
        case 0:
            if selectedGender != "" {
                userInfoPickerDelegate?.onGenderSet!(gender: selectedGender)
            } else {
                userInfoPickerDelegate?.onGenderSet!(gender: .localized(.male))
            }
        case 1:
            if selectedClassNumber != "" {
                userInfoPickerDelegate?.onClassSet!(classNumber: selectedClassNumber)
            } else {
                userInfoPickerDelegate?.onClassSet!(classNumber: classNumber[0])
            }
        case 2:
            if selectedDepartmentName != "" {
                userInfoPickerDelegate?.onDepartmentSet!(departmentName: selectedDepartmentName)
            } else {
                userInfoPickerDelegate?.onDepartmentSet!(departmentName: departmentName[0])
            }
        case 3:
            if selecteedType != "" {
                userInfoPickerDelegate?.onTypeSet!(type: selecteedType)
            } else {
                userInfoPickerDelegate?.onTypeSet!(type: userType[0])
            }
        default:
            LyieLog.mPrint("Default")
        }
        
        userInfoPickerDelegate?.onPickerDismissed()
    }
    
    @IBAction func clearButton(_ sender: Any) {
        switch pickerType {
        case 0:
            userInfoPickerDelegate?.onGenderSet!(gender: "")
        case 1:
            userInfoPickerDelegate?.onClassSet!(classNumber: "")
        case 2:
            userInfoPickerDelegate?.onDepartmentSet!(departmentName: "")
        case 3:
            userInfoPickerDelegate?.onTypeSet!(type: "")
        default:
            LyieLog.mPrint("Default")
        }
        userInfoPickerDelegate?.onPickerDismissed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingLanguage()
        delegatePicker()
        fillData()
        
        saveButton.backgroundColor = StyleManager.colors.leftTitleColor
        clearButton.backgroundColor = StyleManager.colors.leftTitleColor
        pickerView.borderColor = StyleManager.colors.borderColorBlue
        
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let userItem = UserProvider.users(for: user), let studentInfoItem = StudentInfoProvider.studentInfos(for: user), let newUserItem = NewUserProvider.users(for: user) {
            switch pickerType {
            case 0:
                if userItem.gender == "" {
                    picker.selectRow(0, inComponent: 0, animated: true)
                }
                else if userItem.gender == "Male" || userItem.gender == "Erkek" || userItem.gender == "male" || userItem.gender == "erkek" {
                    picker.selectRow(0, inComponent: 0, animated: true)
                }
                else if userItem.gender == "Female" || userItem.gender == "Kadın" || userItem.gender == "female" || userItem.gender == "kadın" {
                    picker.selectRow(1, inComponent: 0, animated: true)
                }
                
            case 1:
                let i = 0
                if studentInfoItem.classNumber == classNumber[i] {
                    picker.selectRow(i, inComponent: 0, animated: true)
                } else {
                    picker.selectRow(0, inComponent: 0, animated: true)
                }
            case 2:
                let i = 0
                if studentInfoItem.departmentName == departmentName[i] {
                    picker.selectRow(i, inComponent: 0, animated: true)
                } else {
                    picker.selectRow(0, inComponent: 0, animated: true)
                }
                
            case 3:
                let i = 0
                if newUserItem.userType == userType[i] {
                    picker.selectRow(i, inComponent: 0, animated: true)
                } else {
                    picker.selectRow(0, inComponent: 0, animated: true)
                }
            default:
                LyieLog.mPrint("Default")
            }
        }
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        picker.reloadAllComponents()
    }

    @objc func endEditing() {
        view.endEditing(true)
    }

    
    @IBAction func cancel(_ sender: Any) {
        userInfoPickerDelegate?.onPickerDismissed()
    }
}

extension StringPickerViewController {
    fileprivate func delegatePicker() {
        picker.delegate = self
        picker.dataSource = self
    }
    
    fileprivate func fillData() {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), let userItem = UserProvider.users(for: user), let studentInfoItem = StudentInfoProvider.studentInfos(for: user), let newUserItem = NewUserProvider.users(for: user) else {
            return
        }
        switch pickerType {
        case 0:
            selectedGender = userItem.gender
        case 1:
            selectedClassNumber = studentInfoItem.classNumber
        case 2:
            selectedDepartmentName = studentInfoItem.departmentName
        case 3:
            selecteedType = newUserItem.userType
        default:
            LyieLog.mPrint("Default")
        }
        
    }
}

// MARK: - UIPickerView Functions
extension StringPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerType {
        case 0:
            return gender.count
        case 1:
            return classNumber.count
        case 2:
            return departmentName.count
        case 3:
            return userType.count
        default:
            return gender.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerType {
        case 0:
            return gender[row]
        case 1:
            return classNumber[row]
        case 2:
            return departmentName[row]
        case 3:
            return userType[row]
        default:
            return gender[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        
        if pickerView.selectedRow(inComponent: component) == row {
            label.textColor = StyleManager.colors.black
            label.font = UIFont (name: "Muli-Bold", size: 27.6)
            
        } else {
            label.textColor = StyleManager.colors.pickerLightGray
            label.font = UIFont (name: "Muli-Bold", size: 22.6)

        }
        
        switch pickerType {
        case 0:
            label.text = "\(gender[row])"
        case 1:
            label.text = "\(classNumber[row])"
        case 2:
            label.text = "\(departmentName[row])"
        case 3:
            label.text = "\(userType[row])"
        default:
            LyieLog.mPrint("Default")
        }
        
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
        switch pickerType {
        case 0:
            selectedGender = gender[row]
        case 1:
            selectedClassNumber = classNumber[row]
        case 2:
            selectedDepartmentName = departmentName[row]
        case 3:
            selecteedType = userType[row]
        default:
            LyieLog.mPrint("Default")
        }
    }
}

