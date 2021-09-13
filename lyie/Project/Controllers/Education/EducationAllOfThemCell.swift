//
//  EducationAllOfThemCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 8.01.2021.
//

import UIKit

class EducationAllOfThemCell: UITableViewCell {
    
    static let reuseIdentifier = "EducationAllOfThemCell"
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var suggestionImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var descView: UIView!
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var onAllButton: UIButton!
    
    var allButtonTapAction: ((EducationAllOfThemCell) -> ())?
    
    func config(titleString: String, desc: String, imageName: String, isHidden: Bool, horizontalViewIsHidden: Bool, count: Int, indexRow: Int, videoUrl: String, cellId: Int, leftButtonValue: Bool, rightButtonValue: Bool, leftButtonText: String, rightButtonText: String) {
        mainView.makeShadow()
        leftView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.textColor = StyleManager.colors.leftTitleColor
        descLabel.textColor = StyleManager.colors.black
        titleText.text = titleString
        suggestionImage.image = UIImage(named: imageName)
        descLabel.text = desc
        horizontalView.isHidden = horizontalViewIsHidden
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        buttonView.isHidden = isHidden
        onAllButton.setTitle("Devam Et", for: .normal)
        buttonView.backgroundColor = StyleManager.colors.leftTitleColor
        buttonView.cornerRadius = 10.0
    }
    
    @IBAction func tappedOnAll(_ sender: Any) {
        LyieLog.mPrint("tappedOnAll")
        self.allButtonTapAction!(self)
    }
}
