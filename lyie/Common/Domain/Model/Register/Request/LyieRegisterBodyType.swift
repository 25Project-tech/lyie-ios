//
//  LyieRegisterBodyType.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class LyieRegisterBodyType: Codable {
    let applicationID: String?
    let parameters: RegisterParameters?
    
    enum CodingKeys: String, CodingKey {
        case applicationID = "ApplicationID"
        case parameters = "parameters"
    }
    
    init(applicationID: String, parameters: RegisterParameters) {
        self.applicationID = applicationID
        self.parameters = parameters
    }
}
