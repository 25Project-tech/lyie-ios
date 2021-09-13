//
//  MentorInfo.swift
//  lyie
//
//  Created by Sevcan Eşim on 16.01.2021.
//

import UIKit

class MentorInfo: UITableViewCell {
    
    static let reuseIdentifier = "MentorInfo"
    
    @IBOutlet weak var pageView: UIView!
    
    func config() {
        pageView.overrideUserInterfaceStyle = .light
    }
}
