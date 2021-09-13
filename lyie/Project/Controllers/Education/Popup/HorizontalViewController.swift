//
//  HorizontalViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 11.04.2021.
//

import UIKit
import ASPVideoPlayer

protocol VideoDelegate {
    func onDismiss()
}

class HorizontalViewController: UIViewController {

    @IBOutlet weak var videoPlayer: ASPVideoPlayerView!
    @IBOutlet weak var playButtonView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var icon: UIImageView!
    
    var videoPlayerIsPlay = false
    var videoText = ""
    var videoDesc = ""
    var videoUrl = ""
    var videoDelegate: VideoDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func tappedVideoPlayer(_ sender: Any) {
        if videoPlayerIsPlay == false {
            playButtonView.isHidden = true
            videoPlayer.playVideo()
            videoPlayerIsPlay = true
        } else {
            playButtonView.isHidden = false
            videoPlayer.pauseVideo()
            videoPlayerIsPlay = false
        }
    }
    
//    @IBAction func tappedCancel(_ sender: Any) {
//        closeFunc()
//        videoDelegate.onDismiss()
//    }
}

extension HorizontalViewController {
    func config() {
        NotificationCenter.default.addObserver(self, selector: #selector(HorizontalViewController.dismissPopup), name: NSNotification.Name("closeVideoCell"), object: nil)
        mainView.backgroundColor = .clear
        self.videoPlayer.gravity = .aspectFill
        self.videoPlayer.videoURL = URL(string: videoUrl)
        self.videoPlayer.rotation = .right
        
        playButtonView.isHidden = true
        videoPlayer.playVideo()
        videoPlayerIsPlay = true
        icon.transform = icon.transform.rotated(by: .pi * 1.5)
    }
    
    func closeFunc() {
        playButtonView.isHidden = false
        videoPlayer.pauseVideo()
        videoPlayerIsPlay = false
    }
    
    @objc func dismissPopup() {
        closeFunc()
    }
}


