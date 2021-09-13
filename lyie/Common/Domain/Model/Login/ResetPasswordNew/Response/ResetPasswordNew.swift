//
//  ResetPasswordNew.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class ResetPasswordNew: Codable {
    var resetPasswordNewResult: ResetPasswordNewResult?
    
    enum CodingKeys: String, CodingKey {
        case resetPasswordNewResult = "ResetPasswordNewResult"
    }
    
    init(resetPasswordNewResult: ResetPasswordNewResult) {
        self.resetPasswordNewResult = resetPasswordNewResult
    }
}

