//
//  CityPickerViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 12.12.2020.
//

import UIKit

class CityPickerViewController: UIViewController, Localizable {
    var userItem: UserItem?
    var selectedPlaceOfBirthRow = 0
    var selectedCityRow = 0
    var placeOfBirth = false
    var userInfoPickerDelegate: UserInfoPickerDelegate?
    
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet var pickerCity: UIPickerView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    func applyLanguage() {
        saveButton.setTitle("Kaydet", for: .normal)
        clearButton.setTitle("Sil", for: .normal)
        cityTitleLabel.text = "Şehir"
    }
    
//    @IBAction func saveCity(_ sender: Any) {
//        if let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) {
//            if placeOfBirth {
//                if selectedPlaceOfBirthRow != 0 {
//                    userInfoPickerDelegate?.onPlaceOfBirthSet!(city: CityServices.getLicensePlateId(by: selectedPlaceOfBirthRow))
//                } else {
//                    userInfoPickerDelegate?.onPlaceOfBirthSet!(city: 0)
//                }
//                userItem.placeofBirth = CityServices.getLicensePlateId(by: selectedPlaceOfBirthRow)
//                UserProvider.update(users: userItem)
//                userInfoPickerDelegate?.onPickerDismissed()
//            } else {
//                if selectedCityRow != 0 {
//                    userInfoPickerDelegate?.onCitySet!(city: CityServices.getLicensePlateId(by: selectedCityRow))
//                } else {
//                    userInfoPickerDelegate?.onCitySet!(city: 0)
//                }
//                userItem.city = CityServices.getLicensePlateId(by: selectedCityRow)
//                UserProvider.update(users: userItem)
//                userInfoPickerDelegate?.onPickerDismissed()
//            }
//        }
//    }
    
//    @IBAction func clearCity(_ sender: Any) {
//        if placeOfBirth {
//            userInfoPickerDelegate?.onPlaceOfBirthSet?(city: 0)
//        } else {
//            userInfoPickerDelegate?.onCitySet!(city: 0)
//        }
//        userInfoPickerDelegate?.onPickerDismissed()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingLanguage()
        delegatePicker()
        fillData()
        
        clearButton.backgroundColor = StyleManager.colors.leftTitleColor
        saveButton.backgroundColor = StyleManager.colors.leftTitleColor
        pickerView.borderColor = StyleManager.colors.borderColorBlue
        
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let userItem = UserProvider.users(for: user) {
            
            if placeOfBirth {
                if userItem.placeofBirth == 0 {
                    pickerCity.selectRow(0, inComponent: 0, animated: true)
                } else {
                    pickerCity.selectRow(selectedPlaceOfBirthRow, inComponent: 0, animated: true)
                }
            } else {
                if userItem.city == 0 {
                    pickerCity.selectRow(0, inComponent: 0, animated: true)
                } else {
                    pickerCity.selectRow(selectedCityRow, inComponent: 0, animated: true)
                }
            }
        }
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pickerCity.reloadAllComponents()
    }

    @objc func endEditing() {
        view.endEditing(true)
    }

    @IBAction func cancel(_ sender: Any) {
        userInfoPickerDelegate?.onPickerDismissed()
    }
}

extension CityPickerViewController {
    fileprivate func delegatePicker() {
        pickerCity.delegate = self
        pickerCity.dataSource = self
    }
    
    fileprivate func fillData() {
        guard let user = UserDefaults.standard.string(forKey: currentUserKey), let userItem = UserProvider.users(for: user) else { return }
        
        if userItem.placeofBirth != 0 || userItem.city != 0 {
            if placeOfBirth {
                selectedPlaceOfBirthRow = userItem.placeofBirth - 1
            } else {
                selectedCityRow = userItem.city - 1
            }
        }
    }
}

// MARK: - UIPickerView Functions
extension CityPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CityServices.allCityList().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CityServices.getName(by: row)
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
        
        label.text = CityServices.getName(by: row)
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
        if placeOfBirth {
            selectedPlaceOfBirthRow = row
        } else {
            selectedCityRow = row
        }
    }
}

