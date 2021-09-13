//
//  PopupsSingleButtonModel.swift
//  SmartCenter
//
//  Created by Sevcan Eşim on 18.02.2021.
//  Copyright © 2021 Vestel A.Ş. All rights reserved.
//

import Foundation

struct PopupsSingleButtonModel {
    var alertTitleText = ""
    var alertButtonTitle = ""
    
    init(alertTitleText: String, alertButtonTitle: String) {
        self.alertTitleText = alertTitleText
        self.alertButtonTitle = alertButtonTitle
    }
}
