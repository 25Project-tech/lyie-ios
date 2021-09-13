//
//  VideoCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.12.2020.
//

import UIKit
import ASPVideoPlayer
import PopupDialog

class VideoCell: UITableViewCell {
    static let reuseIdentifier = "VideoCell"
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var videoPlayer: ASPVideoPlayerView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var playButtonView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var onAllButton: UIButton!
    var videoPlayerIsPlay = false
    
    var allButtonTapAction: ((VideoCell) -> ())?
    var navigateBButtonTapAction: ((VideoCell) -> ())?
    var startValue = false
    
    var leftText = ""
    var rightText = ""
    
    func config(titleString: String, desc: String, imageName: String, isHidden: Bool, horizontalViewIsHidden: Bool, count: Int, indexRow: Int, videoUrl: String, cellId: Int, leftButtonValue: Bool, rightButtonValue: Bool, leftButtonText: String, rightButtonText: String) {
        DispatchQueue.global().asyncAfter(deadline: .now()) {
            DispatchQueue.main.async {
                self.videoPlayer.videoURL = URL(string: videoUrl)
            }
        }
        leftText = leftButtonText
        rightText = rightButtonText
        startValue = false
        mainView.makeShadow()
        self.videoPlayer.gravity = .aspectFit
        self.videoPlayer.seek(0.2)
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        leftView.backgroundColor = StyleManager.colors.leftTitleColor
        titleText.text = titleString
        titleText.textColor = StyleManager.colors.leftTitleColor
        descLabel.text = desc
        descLabel.textColor = StyleManager.colors.leftTitleColor
        buttonView.backgroundColor = StyleManager.colors.leftTitleColor
        buttonView.isHidden = isHidden
        buttonView.cornerRadius = 10.0
        horizontalView.isHidden = horizontalViewIsHidden
        onAllButton.setTitle("Devam Et", for: .normal)
    }
    
    @IBAction func tappedVideoPlayer(_ sender: Any) {
        if !startValue {
            startValue = true
            videoPlayer.seek(0.0)
        }
        self.navigateBButtonTapAction!(self)
    }
    @IBAction func tappedOnAllButton(_ sender: Any) {
        LyieLog.mPrint("tappedOnAll")
        self.allButtonTapAction!(self)
    }
}
