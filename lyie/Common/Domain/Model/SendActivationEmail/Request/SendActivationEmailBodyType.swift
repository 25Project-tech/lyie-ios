//
//  SendActivationEmailBodyType.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

class SendActivationEmailBodyType: Codable {
    let appId: String?
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case appId = "appId"
        case email = "email"
    }
    
    init(appId: String, email: String) {
        self.appId = appId
        self.email = email
    }
}

