//
//  HomeIndicator.swift
//  lyie
//
//  Created by Sevcan Eşim on 16.01.2021.
//

import UIKit

class HomeIndicator: UITableViewCell {
    
    static let reuseIdentifier = "HomeIndicator"
    @IBOutlet weak var mainView: UIView!
    
    func config() {
        mainView.backgroundColor = StyleManager.colors.lineColor
    }
    
}
