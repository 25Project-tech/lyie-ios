//
//  SignUpButtonCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.04.2021.
//

import UIKit
import Parse


class SignUpButtonCell:  UITableViewCell {
    static let reuseIdentifier = "SignUpButtonCell"
    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backButtonView: UIView!
    
    var navigateSaveAction: ((SignUpButtonCell) -> ())?
    var navigateDeleteAction: ((SignUpButtonCell) -> ())?
    
    func config() {
        buttonView.makeShadow()
        buttonView.backgroundColor = StyleManager.colors.leftTitleColor
        backButtonView.backgroundColor = StyleManager.colors.leftTitleColor
        
        buttonView.setTitle("Kaydet", for: .normal)
        backButton.setTitle("Temizle", for: .normal)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        LyieLog.mPrint("Buton")
        self.navigateDeleteAction!(self)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        LyieLog.mPrint("Buton")
        self.navigateSaveAction!(self)
    }
}

