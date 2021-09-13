//
//  ShowProfilePopups.swift
//  lyie
//
//  Created by Sevcan Eşim on 9.12.2020.
//

import Foundation
import PopupDialog

extension ProfileController {
    
    func showStringPicker(animated: Bool = true, pickerType: Int) { //CASE 2
        let customVC = StringPickerViewController(nibName: "StringPickerViewController", bundle: nil)
        customVC.userInfoPickerDelegate = self
        customVC.pickerType = pickerType
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
    
    func showAge(animated: Bool = true) { //CASE 3
        let customVC = AgePickerViewController(nibName: "AgePickerViewController", bundle: nil)
        customVC.userInfoPickerDelegate = self
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
    
    func showCity(animated: Bool = true, placeOfBirth: Bool) { //CASE 2
        let customVC = CityPickerViewController(nibName: "CityPickerViewController", bundle: nil)
        customVC.userInfoPickerDelegate = self
        customVC.placeOfBirth = placeOfBirth
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
    
    func showTF(animated: Bool = true, type: Int) { //CASE 2
        let customVC = TFPopupAlertViewController(nibName: "TFPopupAlertViewController", bundle: nil)
        customVC.tfDelegate = self
        customVC.textFieldType = type
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
    
    func showTV(animated: Bool = true, type: Int) { //CASE 2
        let customVC = TVPopupAlertViewController(nibName: "TVPopupAlertViewController", bundle: nil)
        customVC.tvDelegate = self
        customVC.textViewType = type
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
    func showSearch(animated: Bool = true, type: Int) { //CASE 2
        let customVC = SearchViewController(nibName: "SearchViewController", bundle: nil)
        customVC.searchDelegate = self
        customVC.searchType = type
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
}

