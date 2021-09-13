//
//  ResetPasswordResult.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
struct ResetPasswordResult: Codable {
    var recordFieldName, recordID, responseMessage, responseCode: String?
    var appID, createActivation, isGSMVerified: String?
    
    enum CodingKeys: String, CodingKey {
        case recordFieldName = "RecordFieldName"
        case recordID = "RecordID"
        case responseMessage = "ResponseMessage"
        case responseCode = "ResponseCode"
        case appID = "AppID"
        case createActivation = "CreateActivation"
        case isGSMVerified = "IsGsmVerified"
    }
}
