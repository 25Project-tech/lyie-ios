//
//  ImageCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 23.03.2021.
//

import UIKit

class ImageCell: UITableViewCell {
    
    static let reuseIdentifier = "ImageCell"
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var educationImage: UIImageView!
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var onAllButton: UIButton!
    
    var allButtonTapAction: ((ImageCell) -> ())?
    
    func config(titleString: String, desc: String, imageName: String, isHidden: Bool, horizontalViewIsHidden: Bool, count: Int, indexRow: Int, videoUrl: String, cellId: Int, leftButtonValue: Bool, rightButtonValue: Bool, leftButtonText: String, rightButtonText: String) {
        mainView.makeShadow()
        LyieUtils.loadImage(resource: educationImage, imageURL: imageName, placeHolder: UIImage(named: "backgroundEdu"), isCircle: false)
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

