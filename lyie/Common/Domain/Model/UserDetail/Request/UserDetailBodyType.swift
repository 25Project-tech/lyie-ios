//
//  UserDetailBodyType.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class UserDetailBodyType: Codable {
    let token: String?
    let userAgent: String?
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
        case userAgent = "UserAgent"
    }
    
    init(token: String, userAgent: String) {
        self.token = token
        self.userAgent = userAgent
    }
}


