//
//  Styleable+Notifications.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

extension Notification.Name {
    static let styleDidChange = Notification.Name("StyleDidChangeNotification")
}

extension Styleable where Self: NSObjectProtocol {
    func startObservingStyle() {
        stopObservingStyle()
        NotificationCenter.default.addObserver(forName: .styleDidChange, object: nil, queue: nil) { [weak self] _ in
            self?.applyStyle()
        }
        applyStyle()
    }
    
    func stopObservingStyle() {
        NotificationCenter.default.removeObserver(self, name: .styleDidChange, object: nil)
    }
}

