//
//  AgePickerViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 12.12.2020.
//

import UIKit

class AgePickerViewController: UIViewController, Localizable {

    @IBOutlet weak var popTitleLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var pickerView: UIView!
    
    var userInfoPickerDelegate: UserInfoPickerDelegate?
    var selectedDate: Date?
      
    func applyLanguage() {
        saveButton.setTitle("Kaydet", for: .normal)
        clearButton.setTitle("Sil", for: .normal)
        popTitleLabel.text = "Doğum Tarihi"
    }
    
    @IBAction func cancel(_ sender: Any) {
        userInfoPickerDelegate?.onPickerDismissed()
    }
    
    @IBAction func saveAge(_ sender: Any) {
        selectedDate = datePicker.date
        userInfoPickerDelegate?.onAgeSet!(date: selectedDate!)
        userInfoPickerDelegate?.onPickerDismissed()
    }
    
    @IBAction func clearAge(_ sender: Any) {
        userInfoPickerDelegate?.onAgeSet!(date: Date.init(timeIntervalSince1970: 0))
        userInfoPickerDelegate?.onPickerDismissed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingLanguage()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .gray
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
            datePicker.setValue(UIColor.black, forKeyPath: "textColor")
            datePicker.setValue(0.8, forKeyPath: "alpha")
            datePicker.setValue(false, forKeyPath: "highlightsToday")
        }
        
        saveButton.backgroundColor = StyleManager.colors.leftTitleColor
        clearButton.backgroundColor = StyleManager.colors.leftTitleColor
        pickerView.borderColor = StyleManager.colors.borderColorBlue
        fillData()
    }
    
    func fillData() {
        if let currentUser = UserDefaults.standard.string(forKey: currentUserKey), let userItem = UserProvider.users(for: currentUser) {
            datePicker.locale = .current
            datePicker.maximumDate = Date()
            selectedDate = userItem.dateofBirth
            if(selectedDate != nil) {
                datePicker.date = selectedDate!
            }
        }
    }
}
