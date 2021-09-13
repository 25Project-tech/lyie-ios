//
//  LyieLoginResult.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

// MARK: - LoginResult
struct LyieLoginResult: Codable {
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
}

