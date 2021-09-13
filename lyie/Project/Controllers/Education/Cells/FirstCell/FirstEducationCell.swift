//
//  FirstEducationCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.12.2020.
//

import UIKit

class FirstEducationCell: UITableViewCell {
    static let reuseIdentifier = "FirstEducationCell"
    
    @IBOutlet weak var coverPhoto: UIImageView!
    @IBOutlet weak var leftTitleView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var mainEducationView: UIView!
    @IBOutlet weak var horizontalView: UIView!
    
    
    func config() {
        mainEducationView.makeShadow()
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.textColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = "Girişimcilik Eğitimi 101"
        descLabel.text = "Bu bölüm de girişimciliğin ne olduğu ve girişimciliğin temel kavramları üzerinde duracağız."
    }
}

