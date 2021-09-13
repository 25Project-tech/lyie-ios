//
//  LyieLoginBodyType.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

class LyieLoginBodyType: Codable {
    let email: String?
    let password: String?
    let userAgent: String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case password = "password"
        case userAgent = "UserAgent"
    }
    
    init(email: String, password: String, userAgent: String) {
        self.email = email
        self.password = password
        self.userAgent = userAgent
    }
}

