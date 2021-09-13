//
//  RemindPasswordResponse.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class RemindPasswordResponse: Codable {
    var remindPassword: RemindPassword?
    
    enum CodingKeys: String, CodingKey {
        case remindPassword = "RemindPasswordNewResponse"
    }
    
    init(remindPassword: RemindPassword) {
        self.remindPassword = remindPassword
    }
}
