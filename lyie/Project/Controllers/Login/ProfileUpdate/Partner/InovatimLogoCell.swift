//
//  InovatimLogoCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 29.11.2020.
//

import UIKit

class InovatimLogoCell: UITableViewCell {
    
    static let reuseIdentifier = "InovatimLogoCell"
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    
    func config() {
        logoView.backgroundColor = StyleManager.colors.white
        logoIcon.image = UIImage(named: "Dashboard/inovatim")
        logoView.makeShadow()
        shadowView.makeShadow()
        logoView.topBottomMakeShadow()
    }
    
}
