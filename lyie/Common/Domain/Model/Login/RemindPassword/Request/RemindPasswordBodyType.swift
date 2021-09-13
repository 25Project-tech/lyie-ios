//
//  RemindPasswordBodyType.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class RemindPasswordBodyType: Codable {
    var appID, email, userAgent: String?
    
    enum CodingKeys: String, CodingKey {
        case appID = "appId"
        case email = "email"
        case userAgent = "UserAgent"
    }
    
    init(appID: String, email: String, userAgent: String) {
        self.appID = appID
        self.email = email
        self.userAgent = userAgent
    }
}


