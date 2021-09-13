//
//  PopupsTwoButtonViewController.swift
//  SmartCenter
//
//  Created by Sevcan Eşim on 18.02.2021.
//  Copyright © 2021 Vestel A.Ş. All rights reserved.
//

import UIKit

protocol PopupsTwoButtonViewControllerDelegate {
    func pressAccept()
    func pressCancel()
}

class PopupsTwoButtonViewController: UIViewController {

    @IBOutlet weak var alertImageView: UIImageView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var alertDetailLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
    var alertContent: PopupsModel?
    var popupsTwoButtonDelegate: PopupsTwoButtonViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertImageView.image = alertContent?.alertIcon
        alertLabel.text = alertContent?.alertTitleText
        alertDetailLabel.text = alertContent?.alertDetailText
        cancelButton.setTitle(alertContent?.alertCancelButtonTitle, for: .normal)
        acceptButton.setTitle(alertContent?.alertAcceptButtonTitle, for: .normal)
        acceptButton.backgroundColor = StyleManager.colors.leftTitleColor
    }

    @IBAction func cancelPressed(_ sender: Any) {
        popupsTwoButtonDelegate?.pressCancel()
    }

    @IBAction func acceptPressed(_ sender: Any) {
        popupsTwoButtonDelegate?.pressAccept()
    }
}


