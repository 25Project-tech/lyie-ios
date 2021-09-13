//
//  KargaKargaCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.11.2020.
//

import UIKit

class KargaKargaCell:  UITableViewCell {
    static let reuseIdentifier = "KargaKargaCell"
    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var kargaKargaLogo: UIImageView!
    @IBOutlet weak var horizontalView: UIView!
    
    var navigateKargaTapAction: ((KargaKargaCell) -> ())?
    
    func config() {
        buttonView.backgroundColor = StyleManager.colors.backgroundColor
        kargaKargaLogo.image = UIImage(named: "Profile/kargaLogo")
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        LyieLog.mPrint("Buton")
        self.navigateKargaTapAction!(self)
    }
}
