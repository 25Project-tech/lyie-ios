//
//  ResetPasswordResponse.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
struct ResetPasswordResponseResult: Codable {
    let resetPasswordResult: ResetPasswordResult
    
    enum CodingKeys: String, CodingKey {
        case resetPasswordResult = "ResetPasswordResult"
    }
}
