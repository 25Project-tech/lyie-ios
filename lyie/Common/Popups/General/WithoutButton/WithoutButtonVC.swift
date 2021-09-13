//
//  WithoutButtonVC.swift
//  lyie
//
//  Created by Sevcan Eşim on 22.02.2021.
//

import Foundation
import UIKit

class WithoutButtonVC: UIViewController {
    
    @IBOutlet weak var alertIcon: UIImageView!
    @IBOutlet weak var alertTitleLabel: UILabel!
    @IBOutlet weak var alertDescLabel: UILabel!
    
    var alertContent: PopupsWithoutButtonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertIcon.image = UIImage(named: alertContent?.alertIcon ?? "Settings/warning10")
        alertTitleLabel.text = alertContent?.alertTitleText
        alertDescLabel.text = alertContent?.alertDesc
    }
}

