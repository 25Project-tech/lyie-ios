//
//  ResetPasswordNewBodyType.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class ResetPasswordNewBodyType: Codable {
    let parameters: ResetPasswordNewParameters?
    let userId: String?
    let verificationCode: String?
    
    enum CodingKeys: String, CodingKey {
        case parameters = "parameters"
        case userId = "UserId"
        case verificationCode = "VerificationCode"
    }
    
    init(parameters: ResetPasswordNewParameters, userId: String, verificationCode: String) {
        self.parameters = parameters
        self.userId = userId
        self.verificationCode = verificationCode
    }
}


