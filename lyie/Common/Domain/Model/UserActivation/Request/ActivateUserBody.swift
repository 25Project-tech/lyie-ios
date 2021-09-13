//
//  UserActivationBody.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class ActivateUserBody: Body {
    var bodyType: ActivateUserBodyType?
    
    enum CodingKeys: String, CodingKey {
        case bodyType = "ActivateUser"
    }
    
    override init() { super.init() }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let superdecoder = try container.superDecoder()
        try super.init(from: superdecoder)
        bodyType = try container.decode(ActivateUserBodyType.self, forKey: .bodyType)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(bodyType, forKey: .bodyType)
        
        let superencoder = container.superEncoder()
        try super.encode(to: superencoder)
    }
}
