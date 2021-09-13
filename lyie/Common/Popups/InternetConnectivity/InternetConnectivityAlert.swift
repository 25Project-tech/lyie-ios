//
//  InternetConnectivityAlert.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
import UIKit

class InternetConnectivityAlert: UIView, Localizable {
    
    @IBOutlet weak var textLabel: UILabel!
    
    func applyLanguage() {
        textLabel.text = .localized(.internet_connection)
    }
}
