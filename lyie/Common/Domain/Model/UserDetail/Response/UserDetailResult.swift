//
//  UserDetailResult.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

class UserDetailResult: Codable {
    var recordFieldName, recordID, responseMessage, responseCode: String?
    var firstName, lastName, email, city: String?
    var birthDate, gender, phone, photo: String?
    var newsletter, infoSMS, omvid, appID: String?
    var appName, createActivation, verificationCode, isGSMVerified: String?
    
    enum CodingKeys: String, CodingKey {
        case recordFieldName = "RecordFieldName"
        case recordID = "RecordID"
        case responseMessage = "ResponseMessage"
        case responseCode = "ResponseCode"
        case firstName = "FirstName"
        case lastName = "LastName"
        case email = "Email"
        case city = "City"
        case birthDate = "BirthDate"
        case gender = "Gender"
        case phone = "Phone"
        case photo = "Photo"
        case newsletter = "Newsletter"
        case infoSMS = "InfoSms"
        case omvid = "OMVID"
        case appID = "AppID"
        case appName = "AppName"
        case createActivation = "CreateActivation"
        case verificationCode = "VerificationCode"
        case isGSMVerified = "IsGsmVerified"
    }
    
    init(recordFieldName: String, recordID: String, responseMessage: String, responseCode: String, firstName: String, lastName: String, email: String, city: String, birthDate: String, gender: String, phone: String, photo: String, newsletter: String, infoSMS: String, omvid: String, appID: String, appName: String, createActivation: String, verificationCode: String, isGSMVerified: String) {
        self.recordFieldName = recordFieldName
        self.recordID = recordID
        self.responseMessage = responseMessage
        self.responseCode = responseCode
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.city = city
        self.birthDate = birthDate
        self.gender = gender
        self.phone = phone
        self.photo = photo
        self.newsletter = newsletter
        self.infoSMS = infoSMS
        self.omvid = omvid
        self.appID = appID
        self.appName = appName
        self.createActivation = createActivation
        self.verificationCode = verificationCode
        self.isGSMVerified = isGSMVerified
    }
}
