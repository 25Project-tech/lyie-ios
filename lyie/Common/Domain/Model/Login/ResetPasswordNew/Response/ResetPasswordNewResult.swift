//
//  ResetPasswordNewResult.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class ResetPasswordNewResult: Codable {
    var token, refreshToken, recordFieldName, recordID: String?
    var responseMessage, responseCode, appID, createActivation: String?
    var isGSMVerified: String?
    
    enum CodingKeys: String, CodingKey {
        case token = "Token"
        case refreshToken = "RefreshToken"
        case recordFieldName = "RecordFieldName"
        case recordID = "RecordID"
        case responseMessage = "ResponseMessage"
        case responseCode = "ResponseCode"
        case appID = "AppID"
        case createActivation = "CreateActivation"
        case isGSMVerified = "IsGsmVerified"
    }
    
    init(token: String, refreshToken: String, recordFieldName: String, recordID: String, responseMessage: String, responseCode: String, appID: String, createActivation: String, isGSMVerified: String) {
        self.token = token
        self.refreshToken = refreshToken
        self.recordFieldName = recordFieldName
        self.recordID = recordID
        self.responseMessage = responseMessage
        self.responseCode = responseCode
        self.appID = appID
        self.createActivation = createActivation
        self.isGSMVerified = isGSMVerified
    }
}


