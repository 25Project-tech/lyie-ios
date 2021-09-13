//
//  PopupsTitleOneButtonViewController.swift
//  SmartCenter
//
//  Created by Sevcan Eşim on 18.02.2021.
//  Copyright © 2021 Vestel A.Ş. All rights reserved.
//

import Foundation
import UIKit

protocol PopupsTitleOneButtonViewControllerDelegate {
    func pressButton()
}

class PopupsTitleOneButtonViewController: UIViewController {
    
    @IBOutlet weak var alertIcon: UIImageView!
    @IBOutlet weak var alertTitleLabel: UILabel!
    @IBOutlet weak var alertDescLabel: UILabel!
    @IBOutlet weak var alertButton: UIButton!
    
    var alertContent: PopupsTitleOneButtonModel?
    var popupsTitleOneButtonDelegate: PopupsTitleOneButtonViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertIcon.image = UIImage(named: alertContent?.alertIcon ?? "icon/failedIcon")
        alertTitleLabel.text = alertContent?.alertTitleText
        alertDescLabel.text = alertContent?.alertDesc
        alertButton.setTitle(alertContent?.alertButtonTitle, for: .normal)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        popupsTitleOneButtonDelegate?.pressButton()
    }
}
