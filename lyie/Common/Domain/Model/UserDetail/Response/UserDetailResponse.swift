//
//  UserDetailResponse.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

class UserDetailResponse: Codable {
    var userDetail: UserDetail?
    
    enum CodingKeys: String, CodingKey {
        case userDetail = "GetUserDetailResponse"
    }
    
    init(userDetail: UserDetail) {
        self.userDetail = userDetail
    }
}
