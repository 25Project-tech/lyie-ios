//
//  ScoreCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 26.12.2020.
//

import UIKit

class ScoreCell: UITableViewCell {
    
    static let reuseIdentifier = "ScoreCell"
    
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var scoreDescLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    func config(scoreDesc: String, scoreValue: String) {
        mainView.makeShadow()
        textView.cornerRadius = 10.0
        textView.backgroundColor = StyleManager.colors.scoreViewColor

        scoreDescLabel.text = scoreDesc
        scoreLabel.text = "\(scoreValue) Puan"
        
    }
    
}

