//
//  ActivateUser.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class ActivateUser: Codable {
    var activateUserResult: ActivateUserResult?

    enum CodingKeys: String, CodingKey {
        case activateUserResult = "ActivateUserResult"
    }

    init(activateUserResult: ActivateUserResult) {
        self.activateUserResult = activateUserResult
    }
}

