//
//  ScoreDetailCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 26.12.2020.
//

import UIKit

class ScoreDetailCell: UITableViewCell {
    
    static let reuseIdentifier = "ScoreDetailCell"
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descText1: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var leftView: UIView!
    
    func config() {
        mainView.makeShadow()
        leftView.backgroundColor = StyleManager.colors.leftTitleColor
        
        titleText.textColor = StyleManager.colors.leftTitleColor
        titleText.text = "PUAN AÇIKLAMA SAYFASI"
        descText1.text = "Bu sayfada eğitim süreci boyunca toplayabileceğiniz puanları görebilirsiniz.Puanınızla ilgili bir hesaplama hatası olduğunu düşünüyorsanız mentorunuz ile iletişime geçiniz."
        
    }
    
}
