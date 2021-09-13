//
//  LyieLoginResponse.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
struct LyieLoginResponse: Codable {
    var loginResponse: LoginResponse?
    var firebaseCustomToken: String?

    enum CodingKeys: String, CodingKey {
        case loginResponse = "LoginResponse"
        case firebaseCustomToken = "FirebaseCustomToken"
    }
}
