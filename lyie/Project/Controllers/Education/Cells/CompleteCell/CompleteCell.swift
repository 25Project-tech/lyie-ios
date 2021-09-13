//
//  CompleteCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 3.04.2021.
//

import UIKit

class CompleteCell:  UITableViewCell {
    static let reuseIdentifier = "CompleteCell"
    @IBOutlet weak var buttonView: UIButton!
    
    var navigateTapAction: ((CompleteCell) -> ())?
    
    func config() {
        buttonView.makeShadow()
        buttonView.backgroundColor = StyleManager.colors.leftTitleColor
        buttonView.setTitle("Eğitimi Tamamla", for: .normal)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        LyieLog.mPrint("Buton")
        self.navigateTapAction!(self)
    }
}
