//
//  RemindPassword.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class RemindPassword: Codable {
    var remindPasswordResult: RemindPasswordResult?
    
    enum CodingKeys: String, CodingKey {
        case remindPasswordResult = "RemindPasswordNewResult"
    }
    
    init(remindPasswordResult: RemindPasswordResult) {
        self.remindPasswordResult = remindPasswordResult
    }
}

