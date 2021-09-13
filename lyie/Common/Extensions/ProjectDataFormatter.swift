//
//  ProjectDataFormatter.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

class AidaDateFormatter: DateFormatter {
  
//    override var locale: Locale! {
//        get {
//            if SettingsProvider.currentLanguage == .turkish {
//                return .init(identifier: "tr_TR")
//            } else {
//                return .init(identifier: "en_US")
//            }
//        }
//        
//        set {
//            if SettingsProvider.currentLanguage == .turkish {
//                super.locale =  .init(identifier: "tr_TR")
//            } else {
//                super.locale =  .init(identifier: "en_US")
//            }
//        }
//    }
//    
    override init() {
        super.init()
        locale = .current
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
