//
//  ResetPasswordNewParameters.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class ResetPasswordNewParameters: Codable {
    var password: String?
    var rePassword: String?
    
    enum CodingKeys: String, CodingKey {
        case password = "Password"
        case rePassword = "RePassword"
    }
    
    init() {}
    
    init(password: String, repassword: String) {
        self.password = password
        self.rePassword = repassword
    }
}
