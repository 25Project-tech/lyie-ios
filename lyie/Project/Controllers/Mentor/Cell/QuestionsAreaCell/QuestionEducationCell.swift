//
//  QuestionEducationCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 16.01.2021.
//

import UIKit

class QuestionEducationCell: UITableViewCell {
    static let reuseIdentifier = "QuestionEducationCell"
    
    @IBOutlet weak var coverPhoto: UIImageView!
    @IBOutlet weak var leftTitleView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var mainEducationView: UIView!
    
    func configMentorIno() {
        mainEducationView.makeShadow()
        coverPhoto.image = UIImage(named: "Education/inovation101cover")
        titleText.textColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = "İnovasyon"
        descLabel.text = "İnovasyon ile ilgili soru ve yorumlarınızı bu alandan sorabilirsiniz."
    }
    
    func configMentorIot() {
        mainEducationView.makeShadow()
        coverPhoto.image = UIImage(named: "Education/iot101cover")
        titleText.textColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = "IoT"
        descLabel.text = "IoT ile ilgili soru ve yorumlarınızı bu alandan sorabilirsiniz."
    }
    
    func configMentorYapayZeka() {
        mainEducationView.makeShadow()
        coverPhoto.image = UIImage(named: "Education/ai101cover")
        titleText.textColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = "Yapay Zeka"
        descLabel.text = "Yapay Zeka ile ilgili soru ve yorumlarınızı bu alandan sorabilirsiniz."
    }
}
