//
//  LyieLog.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
import  UIKit

class LyieLog {
    static var shouldShowLogs: Bool!
    
    init(shouldShowLogs: Bool) {
        LyieLog.shouldShowLogs = shouldShowLogs
    }
    
     static func mPrint(_ msg: Any...) {
        if LyieLog.shouldShowLogs {
            print("\(msg)")
        }
    }
}
