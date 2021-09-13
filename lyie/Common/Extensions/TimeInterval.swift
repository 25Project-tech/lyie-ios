//
//  TimeInterval.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
extension TimeInterval {
    
    func toClock() -> String {
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        return String(format: "%0.2d:%0.2d", hours, minutes)
    }
    
    func toDetailedClock() -> String {
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        if hours == 0 && minutes == 0 {
            return ""
        } else {
            return String(format: "%0.2d saat %0.2d dakika", hours, minutes)
        }
    }
    
    var miliSeconds: String {
        return String(format: "%0.2d", Int((truncatingRemainder(dividingBy: 1)) * 1000))
    }
    
    var seconds: String {
        return String(format: "%d", Int(self) % 60)
    }
    
    var minute: String {
        return String(format: "%d", (Int(self) / 60 ) % 60)
    }
    
    var hour: String {
        return String(format: "%d", Int(self) / 3600)
    }
    var hours: Int {
        return  Int(self) / 3600
    }
}
