//
//  ResetPasswordBodyType.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class ResetPasswordBodyType: Codable {
    let parameters: ResetPasswordParameters?
    
    enum CodingKeys: String, CodingKey {
        case parameters = "parameters"
    }
    
    init(parameters: ResetPasswordParameters) {
        self.parameters = parameters
    }
}


