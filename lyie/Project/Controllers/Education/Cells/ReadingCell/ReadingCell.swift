//
//  ReadingCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.12.2020.
//

import UIKit

class ReadingCell: UITableViewCell {
    static let reuseIdentifier = "ReadingCell"
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var suggestionImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var onAllButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var horizontalView: UIView!
    
    var allButtonTapAction: ((ReadingCell) -> ())?
    
    func config(titleString: String, desc: String, imageName: String, isHidden: Bool, horizontalViewIsHidden: Bool, count: Int, indexRow: Int, videoUrl: String, cellId: Int, leftButtonValue: Bool, rightButtonValue: Bool, leftButtonText: String, rightButtonText: String) {
        mainView.makeShadow()
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        buttonView.backgroundColor = StyleManager.colors.leftTitleColor
        buttonView.cornerRadius = 10.0
        onAllButton.setTitle("Araştırmayı Oku", for: .normal)
        leftView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = titleString
        titleText.textColor = StyleManager.colors.leftTitleColor
        suggestionImage.image = UIImage(named: imageName)
        descLabel.text = desc
        descLabel.textColor = StyleManager.colors.leftTitleColor
        buttonView.isHidden = isHidden
        horizontalView.isHidden = horizontalViewIsHidden
    }
    
    @IBAction func tappedOnAll(_ sender: Any) {
        LyieLog.mPrint("tappedOnAll")
        self.allButtonTapAction!(self)
    }
}


