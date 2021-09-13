//
//  TextCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.12.2020.
//

import UIKit

class TextCell: UITableViewCell {
    static let reuseIdentifier = "TextCell"
    
    @IBOutlet weak var leftTitleView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var mainEducationView: UIView!
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var onAllButton: UIButton!
    @IBOutlet weak var textImage: UIImageView!
    
    var allButtonTapAction: ((TextCell) -> ())?
    
    func config(titleString: String, desc: String, imageName: String, isHidden: Bool, horizontalViewIsHidden: Bool, count: Int, indexRow: Int, videoUrl: String, cellId: Int, leftButtonValue: Bool, rightButtonValue: Bool, leftButtonText: String, rightButtonText: String) {
        buttonView.isHidden = isHidden
        horizontalView.isHidden = horizontalViewIsHidden
        onAllButton.setTitle("Devam Et", for: .normal)
        buttonView.backgroundColor = StyleManager.colors.leftTitleColor
        buttonView.cornerRadius = 10.0
        mainEducationView.makeShadow()
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.textColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = titleString
        descLabel.text = desc
        textImage.image = UIImage(named: imageName)
    }
    
    @IBAction func tappedOnAll(_ sender: Any) {
        LyieLog.mPrint("tappedOnAll")
        self.allButtonTapAction!(self)
    }
}


