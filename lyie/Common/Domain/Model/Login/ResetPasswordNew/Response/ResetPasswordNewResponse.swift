//
//  ResetPasswordNewResponse.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class ResetPasswordNewResponse: Codable {
    var resetPasswordNew: ResetPasswordNew?
    
    enum CodingKeys: String, CodingKey {
        case resetPasswordNew = "ResetPasswordNewResponse"
    }
    
    init(resetPasswordNew: ResetPasswordNew) {
        self.resetPasswordNew = resetPasswordNew
    }
}

