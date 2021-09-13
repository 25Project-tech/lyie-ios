//
//  ResetPasswordParameters.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class ResetPasswordParameters: Codable {
    var NewPassword: String?
    var OldPassword: String?
    var ReNewPassword: String?
    var UserId: String?
    
    
    enum CodingKeys: String, CodingKey {
        case NewPassword = "NewPassword"
        case OldPassword = "OldPassword"
        case ReNewPassword = "ReNewPassword"
        case UserId = "UserId"
    }
    
    init() {}
    
    init(newPassword: String, oldPassword: String, reNewPassword: String, userId: String) {
        self.NewPassword = newPassword
        self.OldPassword = oldPassword
        self.ReNewPassword = reNewPassword
        self.UserId = userId
    }
}
