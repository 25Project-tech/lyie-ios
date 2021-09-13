//
//  Localizable+NotifierAdapter.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

extension Notification.Name {
    static let languageDidChange = Notification.Name("LanguageDidChangeNotification")
}

extension Localizable where Self: NSObjectProtocol {
    func startObservingLanguage() {
        stopObservingLanguage()
        NotificationCenter.default.addObserver(forName: .languageDidChange, object: nil, queue: nil) { [weak self] _ in
            self?.applyLanguage()
        }
        applyLanguage()
    }
    
    func stopObservingLanguage() {
        NotificationCenter.default.removeObserver(self, name: .languageDidChange, object: nil)
    }
}
