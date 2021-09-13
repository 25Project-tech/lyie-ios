//
//  ActivateUserResponse.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

class ActivateUserResponse: Codable {
    var activateUser: ActivateUser?
    
    enum CodingKeys: String, CodingKey {
        case activateUser = "ActivateUserResponse"
    }
    
    init(activateUser: ActivateUser) {
        self.activateUser = activateUser
    }
}
