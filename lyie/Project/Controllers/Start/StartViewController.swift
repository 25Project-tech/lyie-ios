//
//  StartViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
import UIKit
//import SwiftyGif


class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: CommonKeys.isUserLoggedIn.rawValue) {
            navigateDashboard()
        } else {
            navigateLogin()
        }
    }

    
    ///Navigate to viewcontrollers according cases
    func navigateLogin() {
        self.performSegue(withIdentifier: "showLogin", sender: nil)
    }
    
    func navigateDashboard() {
        self.performSegue(withIdentifier: "showDashboard", sender: nil)
    }
}


