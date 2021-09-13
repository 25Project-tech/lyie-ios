//
//  IconLabelRightArrowTableViewCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit

class IconLabelRightArrowTableViewCell: UITableViewCell {
    static let reuseIdentifier = "IconLabelRightArrowTableViewCell"
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellIcon: UIImageView?
    @IBOutlet weak var settingCellIcon: UIImageView?
    @IBOutlet weak var cellRightArrow: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var hiddenTextlabel: UILabel!
    @IBOutlet weak var hiddenLeftTextLabel: UILabel!
//    var settingsType: SettingsType!

//    func configSettings(settingFeatures: SettingsFeatureModel) {
//        settingsType = settingFeatures.settingsType
//        cellLabel.text = settingFeatures.name
//        hiddenTextlabel.text = settingFeatures.value
//        hiddenTextlabel.adjustsFontSizeToFitWidth = true
//        hiddenLeftTextLabel.isHidden = true
//        cellLabel.font = UIFont(name: "Muli-Bold", size: 14.6)
//        settingCellIcon?.image = settingFeatures.featureIcon
//        cellIcon?.isHidden = true
//        cellLabel.textColor = UIColor(displayP3Red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)
//        if settingFeatures.settingsType! == .restore{
//            stateLabel.font = UIFont(name: "Muli-Regular", size: 12)
//        }
//        
//        if !settingFeatures.isEnabled {
//            stateLabel.textColor = UIColor.lightGray.withAlphaComponent(0.5)           
//            cellRightArrow.image = UIImage(named: "profile/rightArrow")!.tint(with: UIColor.lightGray.withAlphaComponent(0.5))
//            self.isUserInteractionEnabled = false
//            stateLabel.text = .localized(.no_backup_found)
//        }else{
//            stateLabel.text = settingFeatures.value
//            self.isUserInteractionEnabled = true
//        }
//    }
//    
//    func configSettingsAbout(settingFeatures: SettingsFeatureModel) {
//        cellLabel.text = settingFeatures.name
//        cellLabel.textColor = UIColor(displayP3Red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)
//        settingCellIcon?.image = settingFeatures.featureIcon
//        stateLabel.text = settingFeatures.value
//        hiddenTextlabel.text = settingFeatures.value
//        hiddenLeftTextLabel.text = settingFeatures.name
//        cellIcon!.isHidden = true
//        settingCellIcon?.isHidden = true
//        stateLabel.isHidden = true
//        cellLabel.isHidden = true
//        cellLabel.font = UIFont(name: "Muli-Bold", size: 14.6)
//    }
}
