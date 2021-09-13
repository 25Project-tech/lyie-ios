//
//  NavigateButtonCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 29.11.2020.
//

import UIKit
enum PageStep: String {
    case first = "First"
    case second = "Second"
    case third = "Third"
}

class NavigateButtonCell:  UITableViewCell {
    static let reuseIdentifier = "NavigateButtonCell"
    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backButtonView: UIView!
    
    var navigateTapAction: ((NavigateButtonCell) -> ())?
    var navigateBackTapAction: ((NavigateButtonCell) -> ())?
    
    func config(PageStep: PageStep?) {
        buttonView.makeShadow()
        buttonView.backgroundColor = StyleManager.colors.leftTitleColor
        backButtonView.backgroundColor = StyleManager.colors.leftTitleColor
        switch PageStep {
        case .first:
            if let user = UserDefaults.standard.string(forKey: currentUserKey), let userItem = UserProvider.users(for: user) {
                if userItem.userType == "Student" {
                    buttonView.setTitle("Devam Et 1/2", for: .normal)
                }  else {
                    buttonView.setTitle("Tamamla", for: .normal)
                }
            } else {
                buttonView.setTitle("Devam Et 1/2", for: .normal)
            }
//            buttonView.setTitle("Devam Et 1/3", for: .normal)
            
            backButtonView.isHidden = true
        case .second:
//            buttonView.setTitle("Devam Et 2/3", for: .normal)
            buttonView.setTitle("Tamamla", for: .normal)
            backButton.setTitle("Geri Dön 1/2", for: .normal)
//            backButton.setTitle("Geri Dön 1/3", for: .normal)
        case .third:
            buttonView.setTitle("Tamamla", for: .normal)
            backButton.setTitle("Geri Dön 2/3", for: .normal)
        default:
            buttonView.setTitle("Devam Et 1/3", for: .normal)
        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        LyieLog.mPrint("Buton")
        self.navigateTapAction!(self)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        LyieLog.mPrint("Buton")
        self.navigateBackTapAction!(self)
    }
}
