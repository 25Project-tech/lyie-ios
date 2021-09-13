//
//  Localization.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

enum LocalizedLanguage: String, EnumCollection {
    
    case english
    case turkish
    
    var originalTitle: String {
        switch self {
        case .english: return "English"
        case .turkish: return "Türkçe"
        }
    }
    
    init?(preferredLanguage: String) {
        guard let languageDesignator = preferredLanguage.split(separator: "-").first else {
            return nil
        }
        
        switch String(languageDesignator) {
        case LocalizedLanguage.english.designator: self = .english
        case LocalizedLanguage.turkish.designator: self = .turkish
        default: return nil
        }
    }
    
    var designator: String {
        switch self {
        case .english: return "en"
        case .turkish: return "tr"
        }
    }
    
    var regionCode: String {
        switch self {
        case .turkish: return "TR"
        default: return "EU"
        }
    }
}

extension String {
    
    static func localized(_ key: LocalizationKey, for language: LocalizedLanguage = .turkish) -> String {
        return NSLocalizedString(key.rawValue, tableName: language.rawValue, comment: key.rawValue)
    }
}
