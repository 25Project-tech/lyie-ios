//
//  ActivateUserBodyType.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class ActivateUserBodyType: Codable {
    var verificationCode: String?
    
    enum CodingKeys: String, CodingKey {
        case verificationCode = "VerificationCode"
    }
    
    init(verificationCode: String) {
        self.verificationCode = verificationCode
    }
}

