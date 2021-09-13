//
//  DashboardController.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit
import CoreBluetooth
import Reachability

extension Notification.Name {
    static let onDeviceConnectionChanged = Notification.Name("onDeviceConnectionChanged")
}

class DashboardController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.tintColor = StyleManager.colors.background
    }
}
