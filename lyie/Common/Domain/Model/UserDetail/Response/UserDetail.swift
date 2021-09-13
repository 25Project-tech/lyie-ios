//
//  UserDetail.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

class UserDetail: Codable {
    var userDetailResult: UserDetailResult?
    
    enum CodingKeys: String, CodingKey {
        case userDetailResult = "GetUserDetailResult"
    }
    
    init(userDetailResult: UserDetailResult) {
        self.userDetailResult = userDetailResult
    }
}
