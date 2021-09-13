//
//  GoogleLoginResponseResult.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
struct GoogleLoginResponseResult: Codable {
    let token: String?
    let refreshToken: String?
    let recordFieldName: String?
    let recordID: String?
    let responseMessage: String?
    let responseCode: String?
    let appID: Bool?
    let createActivation: Bool?
    let isGsmVerified: Bool?
    
    
    enum CodingKeys: String, CodingKey {
        case token = "Token"
        case refreshToken = "RefreshToken"
        case recordFieldName = "RecordFieldName"
        case recordID = "RecordID"
        case responseMessage = "ResponseMessage"
        case responseCode = "ResponseCode"
        case appID = "AppID"
        case createActivation = "CreateActivation"
        case isGsmVerified = "IsGsmVerified"
    }
}
