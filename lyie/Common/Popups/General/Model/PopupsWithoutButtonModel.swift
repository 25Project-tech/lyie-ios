//
//  PopupsWithoutButtonModel.swift
//  SmartCenter
//
//  Created by Sevcan Eşim on 18.02.2021.
//  Copyright © 2021 Vestel A.Ş. All rights reserved.
//

import Foundation

struct PopupsWithoutButtonModel {
    var alertIcon = ""
    var alertTitleText = ""
    var alertDesc = ""
    init(alertIcon: String, alertTitleText: String, alertDesc: String) {
        self.alertIcon = alertIcon
        self.alertTitleText = alertTitleText
        self.alertDesc = alertDesc
    }
}
