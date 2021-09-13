//
//  UIStoryboard.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit.UIStoryboard

extension UIStoryboard {

    convenience init(name: String) {
        self.init(name: name, bundle: nil)
    }

    static var common: UIStoryboard { return UIStoryboard(name: "Common") }
    static var home: UIStoryboard { return UIStoryboard(name: "HomePage") }
    static var loginRegister: UIStoryboard { return UIStoryboard(name: "LoginRegister") }
    static var main: UIStoryboard { return UIStoryboard(name: "Main") }
    static var dashboard: UIStoryboard { return UIStoryboard(name: "Dashboard") }
    static var start: UIStoryboard { return UIStoryboard(name: "Start") }
    static var profile: UIStoryboard { return UIStoryboard(name: "Profile") }
    static var education: UIStoryboard { return UIStoryboard(name: "Education") }
    static var researches: UIStoryboard { return UIStoryboard(name: "Researches") }
    static var ozgelecek: UIStoryboard { return UIStoryboard(name: "Ozgelecek") }
    static var inovatim: UIStoryboard { return UIStoryboard(name: "Inovatim") }
    static var score: UIStoryboard { return UIStoryboard(name: "Score") }
    static var mentor: UIStoryboard { return UIStoryboard(name: "Mentor") }
    static var popups: UIStoryboard { return UIStoryboard(name: "Popups") }
}
