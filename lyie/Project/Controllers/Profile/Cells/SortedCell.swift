//
//  SortedCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 17.04.2021.
//

import UIKit

class SortedCell:  UITableViewCell {
    static let reuseIdentifier = "SortedCell"
    
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet weak var sortedView: UIView!
    @IBOutlet weak var profileDetailButton: UIButton!
    @IBOutlet weak var ClassDetailButton: UIButton!
    @IBOutlet weak var secondClassDetailButton: UIButton!
    
    var navigateProfileDetailAction: ((SortedCell) -> ())?
    var navigateClassDetailAction: ((SortedCell) -> ())?
    var navigateSecondClassDetailAction: ((SortedCell) -> ())?
    
    func config() {
        if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey) {
            if let userItem = UserProvider.users(for: currentUserInfo) {
                if userItem.userType != "Mentor" {
                    secondClassDetailButton.isHidden = true
                }
                
                if userItem.userType == "User" {
                    secondClassDetailButton.isHidden = true
                    ClassDetailButton.isHidden = true
                }
            }
        }
        
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        horizontalView.isHidden = true
        profileDetailButton.backgroundColor = StyleManager.colors.leftTitleColor
        ClassDetailButton.backgroundColor = StyleManager.colors.leftTitleColor
        ClassDetailButton.setImage(UIImage(named: "Profile/blueClass")?.withTintColor(.white), for: .normal)
        secondClassDetailButton.setImage(UIImage(named: "Profile/blueClass")?.withTintColor(.white), for: .normal)
        secondClassDetailButton.backgroundColor = StyleManager.colors.leftTitleColor
        profileDetailButton.cornerRadius = 10.0
        ClassDetailButton.cornerRadius = 10.0
        secondClassDetailButton.cornerRadius = 10.0
    }
    
    @IBAction func firstbuttonTapped(_ sender: Any) {
        LyieLog.mPrint("Buton")
        self.navigateProfileDetailAction!(self)
    }
    
    @IBAction func secondButtonTapped(_ sender: Any) {
        LyieLog.mPrint("Buton")
        self.navigateClassDetailAction!(self)
    }
    
    @IBAction func thirdButtonTapped(_ sender: Any) {
        LyieLog.mPrint("Buton")
        self.navigateSecondClassDetailAction!(self)
    }
}

