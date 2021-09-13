//
//  GoogleLoginResponse.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
struct GoogleLoginResponse: Codable {
    let response: GoogleLoginResponseResult?
    
    enum CodingKeys: String, CodingKey {
        case response = "LoginByGoogleResult"
    }
}
