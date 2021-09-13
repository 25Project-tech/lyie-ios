//
//  RegisterParameters.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
class RegisterParameters: Codable {
    var birthDate: String?
    var cityCode: String?
    var email: String?
    var firstName: String?
    var gender: String?
    var infoSms: String?
    var lastName: String?
    var newsLetterValid: String?
    var password: String?
    var phone: String?
    var photo: String?
    var rePassword: String?
    
    
    enum CodingKeys: String, CodingKey {
        case birthDate = "BirthDate"
        case cityCode = "CityCode"
        case email = "Email"
        case firstName = "FirstName"
        case gender = "Gender"
        case infoSms = "InfoSms"
        case lastName = "LastName"
        case newsLetterValid = "NewsLetterValid"
        case password = "Password"
        case phone = "Phone"
        case photo = "Photo"
        case rePassword = "RePassword"
    }
    
    init() {}
    init(birthDate: String, cityCode: String, email: String, firstName: String, gender: String, infoSms: String, lastName: String, newsLetterValid: String, password: String, phone: String, photo: String, rePassword: String) {
        self.birthDate = birthDate
        self.cityCode = cityCode
        self.email = email
        self.firstName = firstName
        self.gender = gender
        self.infoSms = infoSms
        self.lastName = lastName
        self.newsLetterValid = newsLetterValid
        self.password = password
        self.phone = phone
        self.photo = photo
        self.rePassword = rePassword
    }
}


