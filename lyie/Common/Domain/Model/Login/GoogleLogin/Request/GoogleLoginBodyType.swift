//
//  GoogleLoginBodyType.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class GoogleLoginBodyType: Codable {
    let token: String?
    let applicationId: String?
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
        case applicationId = "ApplicationID"
    }
    
    init(token: String, applicationId: String) {
        self.token = token
        self.applicationId = applicationId
    }
}
