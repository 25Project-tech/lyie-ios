//
//  SendActivationMailResult.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class SendActivationMailResult: Codable {
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
    
    init(recordFieldName: String, recordID: String, responseMessage: String, responseCode: String, appID: String, createActivation: String, isGSMVerified: String) {
        self.recordFieldName = recordFieldName
        self.recordID = recordID
        self.responseMessage = responseMessage
        self.responseCode = responseCode
        self.appID = appID
        self.createActivation = createActivation
        self.isGSMVerified = isGSMVerified
    }
}
