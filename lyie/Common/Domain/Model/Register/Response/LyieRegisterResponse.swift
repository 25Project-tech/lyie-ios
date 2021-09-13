//
//  LyieRegisterResponse.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

struct LyieRegisterResponse: Codable {
    let response: LyieRegisterResponseResult?
    
    enum CodingKeys: String, CodingKey {
        case response = "CreateUserNewResponse"
    }
}
