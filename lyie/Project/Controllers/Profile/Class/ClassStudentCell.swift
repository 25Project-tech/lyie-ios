//
//  ClassStudentCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 17.04.2021.
//

import UIKit

class ClassStudentCell: UITableViewCell {
    
    static let reuseIdentifier = "ClassStudentCell"
    
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var hsName: UILabel!
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var horizontalView: UIView!
    
    func config(isHidden: Bool, nameText: String, hgName: String, score: String, imageS: String) {
        idView.makeShadow()
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        horizontalView.isHidden = isHidden
        scoreButton.isUserInteractionEnabled = false
        let nameArray = nameText.split(separator: " ")
        if nameText != "" {
            name.text = String(nameArray[0])
            name.textColor = .black
            if nameArray.count > 1 {
                surname.text = String(nameArray[1])
            } else {
                surname.text = ""
            }
            surname.textColor = .black
        } else {
            name.text = ""
            surname.text = ""
        }
        
        
        hsName.text = hgName
        hsName.textColor = StyleManager.colors.leftTitleColor
        
        scoreButton.setTitle(score, for: .normal)
        LyieUtils.loadImage(resource: profilePic, imageURL: imageS, placeHolder: UIImage(named: "Profile/profile-1"), isCircle: false)
    }
}
