//
//  SendActivationMailResponse.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

class SendActivationMailResponse: Codable {
    var sendActivationMailResponse: SendActivationMail?
    
    enum CodingKeys: String, CodingKey {
        case sendActivationMailResponse = "SendActivationMailResponse"
    }
    
    init(sendActivationMailResponse: SendActivationMail) {
        self.sendActivationMailResponse = sendActivationMailResponse
    }
}

