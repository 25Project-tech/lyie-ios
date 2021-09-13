//
//  PopupsModel.swift
//  SmartCenter
//
//  Created by Sevcan Eşim on 18.02.2021.
//  Copyright © 2021 Vestel A.Ş. All rights reserved.
//

import Foundation
import UIKit

struct PopupsModel {
    var alertIcon = UIImage()
    var alertTitleText = ""
    var alertDetailText = ""
    var alertAcceptButtonTitle = ""
    var alertCancelButtonTitle = ""
    
    init(alertIcon: UIImage!, alertTitleText: String, alertDetailText: String? = nil, alertAcceptButtonTitle: String, alertCancelButtonTitle: String) {
        self.alertIcon = alertIcon!
        self.alertTitleText = alertTitleText
        self.alertDetailText = alertDetailText ?? ""
        self.alertCancelButtonTitle = alertCancelButtonTitle
        self.alertAcceptButtonTitle = alertAcceptButtonTitle
    }
}
