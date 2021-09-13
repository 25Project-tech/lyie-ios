//
//  SuggestionCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.12.2020.
//

import UIKit

class SuggestionCell: UITableViewCell {
    static let reuseIdentifier = "SuggestionCell"
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var suggestionImage: UIImageView!
    
    func config() {
        mainView.makeShadow()
        leftView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = "Kitap Önerisi"
        titleText.textColor = StyleManager.colors.leftTitleColor
        suggestionImage.image = UIImage(named: "kitap")
    }
    
}
