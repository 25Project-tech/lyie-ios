//
//  Header.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class Header: Codable {
    let authHeader: AuthHeader?
    
    enum CodingKeys: String, CodingKey {
        case authHeader = "AuthHeader"
    }
    
    init(authHeader: AuthHeader) {
        self.authHeader = authHeader
    }
}
