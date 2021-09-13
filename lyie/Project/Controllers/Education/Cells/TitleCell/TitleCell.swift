//
//  TitleCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 24.01.2021.
//

import UIKit

class TitleCell: UITableViewCell {
    
    static let reuseIdentifier = "TitleCell"
    
    @IBOutlet weak var leftTitleView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var mainEducationView: UIView!
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet weak var textImage: UIImageView!
    @IBOutlet var allButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    
    var allButtonTapAction: ((TitleCell) -> ())?
    
    func config(titleString: String, desc: String, imageName: String, isHidden: Bool, horizontalViewIsHidden: Bool, count: Int, indexRow: Int, videoUrl: String, cellId: Int, leftButtonValue: Bool, rightButtonValue: Bool, leftButtonText: String, rightButtonText: String) {
        mainEducationView.makeShadow()
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.textColor = StyleManager.colors.leftTitleColor
        leftTitleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = titleString
        descLabel.text = desc
        textImage.image = UIImage(named: imageName)
        allButton.setTitle("Araştırmayı Oku", for: .normal)
        allButton.backgroundColor = StyleManager.colors.leftTitleColor
        allButton.cornerRadius = 10.0
        buttonView.isHidden = false
        horizontalView.isHidden = horizontalViewIsHidden
    }
    
    @IBAction func tappedAllBButton(_ sender: Any) {
        LyieLog.mPrint("tappedOnAll")
        self.allButtonTapAction!(self)
    }
}

