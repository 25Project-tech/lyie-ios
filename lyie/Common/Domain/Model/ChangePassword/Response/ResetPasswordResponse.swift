//
//  VestelResetPasswordResponse.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
struct ResetPasswordResponse: Codable {
    let response: ResetPasswordResponseResult?
    
    enum CodingKeys: String, CodingKey {
        case response = "ResetPasswordResponse"
    }
}