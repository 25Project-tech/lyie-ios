//
//  SendActivationMail.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

class SendActivationMail: Codable {
    var sendActivationMailResult: SendActivationMailResult?

    enum CodingKeys: String, CodingKey {
        case sendActivationMailResult = "SendActivationMailResult"
    }

    init(sendActivationMailResult: SendActivationMailResult) {
        self.sendActivationMailResult = sendActivationMailResult
    }
}

