//
//  PopupsSingleButtonViewController.swift
//  SmartCenter
//
//  Created by Sevcan Eşim on 18.02.2021.
//  Copyright © 2021 Vestel A.Ş. All rights reserved.
//

import UIKit

protocol PopupsSingleButtonViewControllerDelegate {
    func pressButton()
}

class PopupsSingleButtonViewController: UIViewController {

    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var alertButton: UIButton!
    
    var alertContent: PopupsSingleButtonModel?
    var popupsSingleButtonDelegate: PopupsSingleButtonViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertButton.backgroundColor = StyleManager.colors.leftTitleColor
        alertLabel.text = alertContent?.alertTitleText
        alertButton.setTitle(alertContent?.alertButtonTitle, for: .normal)
    }

    @IBAction func cancelPressed(_ sender: Any) {
        popupsSingleButtonDelegate?.pressButton()
    }

}

