//
//  UITableViewCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
import UIKit

extension UITableViewCell {
    
    func BG(_ block: @escaping ()->Void) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
    
    func UI(_ block: @escaping ()->Void) {
        DispatchQueue.main.async(execute: block)
    }
    
//EXAMPLE
//    func configSleepInfoStrings(deepSleep:TimeInterval, lightSleep:TimeInterval, awake:TimeInterval,fullSleep:TimeInterval,suffixArray:[String]) -> [NSMutableAttributedString] {
//        //Config Attributes
//        let valueAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "Muli-Semibold", size: 20.0) ?? ""]
//        let unitAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "Muli", size: 15.0) ?? ""]
//
//        //hrs & min configuration
//        let hourString = NSAttributedString(string: "\(suffixArray[0])", attributes: unitAttribute)
//        let minuteString = NSAttributedString(string: "\(suffixArray[1])", attributes: unitAttribute)
//
//        //Deep Sleep config
//        let deepHourString = NSMutableAttributedString(string: deepSleep.hour, attributes: valueAttribute)
//        deepHourString.append(hourString)
//
//        let deepMinuteString = NSMutableAttributedString(string: deepSleep.minute, attributes: valueAttribute)
//        deepMinuteString.append(minuteString)
//
//        //Light Sleep config
//        let lightHourString = NSMutableAttributedString(string: lightSleep.hour, attributes: valueAttribute)
//        lightHourString.append(hourString)
//
//        let lightMinuteString = NSMutableAttributedString(string: lightSleep.minute, attributes: valueAttribute)
//        lightMinuteString.append(minuteString)
//
//        //Awake config
//        let awakeMinuteString = NSMutableAttributedString(string: awake.toClock(), attributes: valueAttribute)
//        //awakeMinuteString.append(minuteString)
//
//        //Full config
//        let fullSleepHourString = NSMutableAttributedString(string: fullSleep.hour, attributes: valueAttribute)
//        fullSleepHourString.append(hourString)
//
//        let fullSleepMinuteString = NSMutableAttributedString(string: fullSleep.minute, attributes: valueAttribute)
//        fullSleepMinuteString.append(minuteString)
//
//        return [deepHourString, deepMinuteString, lightHourString, lightMinuteString, awakeMinuteString, fullSleepHourString,fullSleepMinuteString]
//    }
}
