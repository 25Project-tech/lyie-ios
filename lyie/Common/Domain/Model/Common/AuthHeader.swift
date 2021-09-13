//
//  AuthHeader.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class AuthHeader: Codable {
    let username: String?
    let password: String?
    
    enum CodingKeys: String, CodingKey {
        case username = "Username"
        case password = "Password"
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
